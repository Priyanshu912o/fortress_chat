import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/chat_room.dart';

class ChatRoomModel extends ChatRoom {
  const ChatRoomModel({
    required super.createdAt,
    required super.chatRoomId,
    required super.isDirect,
    required super.participantUids,
    super.groupName,
    super.groupDpUrl,
    super.adminIds = const [],
    super.lastMessageBody,
    super.lastMessageAt,
    super.lastSenderId,
    super.unreadCount = 0,
    super.otherUserName,
    super.otherUserDpUrl,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json, {String? currentUid}) {
    final isDirect = json['isDirect'] as bool? ?? true;
    final participants = json['participants'] as List<dynamic>? ?? [];

    final participantUids = participants
        .map((p) => (p as Map<String, dynamic>)['uid'] as String)
        .toList();

    final adminIds = participants
        .where((p) => (p as Map<String, dynamic>)['role'] == 'ADMIN')
        .map((p) => (p as Map<String, dynamic>)['uid'] as String)
        .toList();

    String? otherUserName;
    String? otherUserDpUrl;

    if (isDirect) {
      Map<String, dynamic>? otherParticipant;
      for (final p in participants) {
        if (p is Map<String, dynamic> && p['uid'] != currentUid) {
          otherParticipant = p;
          break;
        }
      }
      if (otherParticipant != null) {
        final user = otherParticipant['user'] as Map<String, dynamic>?;
        otherUserName = user?['name'] as String?;
        otherUserDpUrl = user?['dpUrl'] as String?;
      }
    }

    return ChatRoomModel(
      chatRoomId: json['id'] as String,
      isDirect: isDirect,
      groupName: json['groupName'] as String?,
      groupDpUrl: json['groupDpUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      participantUids: participantUids,
      adminIds: adminIds,
      lastMessageBody: json['lastMessageBody'] as String?,
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.parse(json['lastMessageAt'] as String)
          : null,
      lastSenderId: json['lastSenderId'] as String?,
      unreadCount: json['unreadCount'] as int? ?? 0,
      otherUserName: otherUserName,
      otherUserDpUrl: otherUserDpUrl,
    );
  }

  factory ChatRoomModel.fromDrift(CachedChatRoom row) {
    return ChatRoomModel(
      chatRoomId: row.id,
      isDirect: row.isDirect,
      groupName: row.groupName,
      groupDpUrl: row.groupDpUrl,
      createdAt: row.createdAt,
      participantUids: row.participantUids.split(',').where((s) => s.isNotEmpty).toList(),
      lastMessageBody: row.lastMessageBody,
      lastMessageAt: row.lastMessageAt,
      lastSenderId: row.lastSenderId,
      unreadCount: row.unreadCount,
      otherUserName: row.otherUserName,
      otherUserDpUrl: row.otherUserDpUrl,
    );
  }

  CachedChatRoomsCompanion toDrift() {
    return CachedChatRoomsCompanion(
      id: Value(chatRoomId),
      isDirect: Value(isDirect),
      groupName: Value(groupName),
      groupDpUrl: Value(groupDpUrl),
      createdAt: Value(createdAt),
      participantUids: Value(participantUids.join(',')),
      lastMessageBody: Value(lastMessageBody),
      lastMessageAt: Value(lastMessageAt),
      lastSenderId: Value(lastSenderId),
      unreadCount: Value(unreadCount),
      otherUserName: Value(otherUserName),
      otherUserDpUrl: Value(otherUserDpUrl),
    );
  }
}
