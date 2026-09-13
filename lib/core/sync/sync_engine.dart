import 'dart:async';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../network/connectivity_service.dart';
import '../network/websocket_service.dart';

@lazySingleton
class SyncEngine {
  final AppDatabase _db;
  final ApiClient _apiClient;
  final WebSocketService _wsService;
  final ConnectivityService _connectivity;
  final FirebaseAuth _auth;

  StreamSubscription? _connectivitySubscription;
  StreamSubscription? _wsEventsSubscription;
  bool _isSyncing = false;

  SyncEngine(
    this._db,
    this._apiClient,
    this._wsService,
    this._connectivity,
    this._auth,
  ) {
    _init();
  }

  void _init() {
    _connectivitySubscription = _connectivity.isOnlineStream.listen((online) {
      if (online) {
        flushOutbox();
      }
    });

    _wsEventsSubscription = _wsService.events.listen(_handleWsEvent);
  }

  Future<void> _handleWsEvent(Map<String, dynamic> event) async {
    final type = event['type'] as String?;
    final data = event['data'] as Map<String, dynamic>?;

    if (type == null || data == null) return;

    final currentUid = _auth.currentUser?.uid;

    switch (type) {
      case 'message_new': {
        final chatRoomId = data['chatRoomId'] as String;
        final senderId = data['senderId'] as String;
        final clientMessageId = data['clientMessageId'] as String;
        final serverMessageId = data['id'] as String;
        final body = data['body'] as String;
        final sentAt = DateTime.parse(data['sentAt'] as String);
        final sender = data['sender'] as Map<String, dynamic>?;
        final senderName = sender?['name'] as String?;

        final isMe = senderId == currentUid;

        // Upsert into cached messages
        await _db.messageDao.upsertMessage(
          CachedMessagesCompanion(
            id: Value(clientMessageId),
            clientMessageId: Value(clientMessageId),
            serverMessageId: Value(serverMessageId),
            chatRoomId: Value(chatRoomId),
            senderId: Value(senderId),
            senderName: Value(senderName),
            body: Value(body),
            sentAt: Value(sentAt),
            status: const Value('delivered'),
            isMe: Value(isMe),
          ),
        );

        // Update chat room last message
        await _db.chatRoomDao.updateLastMessage(chatRoomId, body, sentAt, senderId);
        if (!isMe) {
          await _db.chatRoomDao.incrementUnreadCount(chatRoomId);
          // Send delivered receipt via API
          try {
            await _apiClient.post('/api/messages/$serverMessageId/delivered');
          } catch (_) {}
        }
        break;
      }

      case 'message_ack': {
        final clientMessageId = data['clientMessageId'] as String;
        final serverMessageId = data['serverMessageId'] as String;

        await _db.messageDao.updateMessageStatus(
          clientMessageId,
          'sent',
          serverMessageId: serverMessageId,
        );
        await _db.messageDao.deletePendingMessage(clientMessageId);
        break;
      }

      case 'message_delivered': {
        final messageId = data['messageId'] as String;
        // Search by serverMessageId and update status
        break;
      }

      case 'message_read': {
        final chatRoomId = data['chatRoomId'] as String;
        final uid = data['uid'] as String;
        if (uid != currentUid) {
          // Other user read messages
        }
        break;
      }

      case 'presence': {
        final uid = data['uid'] as String;
        final isOnline = data['isOnline'] as bool? ?? false;
        final lastSeenStr = data['lastSeen'] as String?;
        final lastSeen = lastSeenStr != null ? DateTime.tryParse(lastSeenStr) : null;

        if (lastSeen != null) {
          await _db.userCacheDao.updatePresence(uid, isOnline, lastSeen);
        }
        break;
      }
    }
  }

  Future<void> enqueueMessage({
    required String chatRoomId,
    required String body,
    required String clientMessageId,
    String? senderName,
  }) async {
    final currentUid = _auth.currentUser?.uid ?? '';
    final now = DateTime.now();

    // 1. Insert into CachedMessages as 'pending' for immediate optimistic UI update
    await _db.messageDao.upsertMessage(
      CachedMessagesCompanion(
        id: Value(clientMessageId),
        clientMessageId: Value(clientMessageId),
        chatRoomId: Value(chatRoomId),
        senderId: Value(currentUid),
        senderName: Value(senderName),
        body: Value(body),
        sentAt: Value(now),
        status: const Value('pending'),
        isMe: const Value(true),
      ),
    );

    // 2. Insert into PendingMessages outbox
    await _db.messageDao.insertPendingMessage(
      PendingMessagesCompanion(
        clientMessageId: Value(clientMessageId),
        chatRoomId: Value(chatRoomId),
        body: Value(body),
        createdAt: Value(now),
        status: const Value('pending'),
      ),
    );

    // 3. Update room's last message locally
    await _db.chatRoomDao.updateLastMessage(chatRoomId, body, now, currentUid);

    // 4. Flush outbox if online
    if (_connectivity.isOnline) {
      flushOutbox();
    }
  }

  Future<void> flushOutbox() async {
    if (_isSyncing || !_connectivity.isOnline) return;
    _isSyncing = true;

    try {
      final pendingList = await _db.messageDao.getPendingMessages();

      for (final pending in pendingList) {
        if (!_connectivity.isOnline) break;

        try {
          await _db.messageDao.updatePendingStatus(pending.clientMessageId, 'sending');
          await _db.messageDao.updateMessageStatus(pending.clientMessageId, 'sending');

          final response = await _apiClient.post(
            '/api/messages',
            data: {
              'chatRoomId': pending.chatRoomId,
              'body': pending.body,
              'clientMessageId': pending.clientMessageId,
            },
          );

          if (response.statusCode == 201 || response.statusCode == 200) {
            final data = response.data as Map<String, dynamic>;
            final serverMessageId = data['id'] as String;

            await _db.messageDao.updateMessageStatus(
              pending.clientMessageId,
              'sent',
              serverMessageId: serverMessageId,
            );
            await _db.messageDao.deletePendingMessage(pending.clientMessageId);
          }
        } catch (e) {
          await _db.messageDao.updatePendingStatus(
            pending.clientMessageId,
            'failed',
            error: e.toString(),
          );
          await _db.messageDao.updateMessageStatus(pending.clientMessageId, 'failed');
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _wsEventsSubscription?.cancel();
  }
}
