import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/components/chat_exceptions.dart';
import '../../../../core/components/chat_failures.dart';
import '../../../../core/network/websocket_service.dart';
import '../../../../core/sync/sync_engine.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repository/messaging_repository.dart';
import '../data_sources/messages_local_data_source.dart';
import '../data_sources/messages_remote_data_source.dart';

@LazySingleton(as: MessagingRepository)
class MessagingRepositoryImpl implements MessagingRepository {
  final MessagesRemoteDataSource _remoteDataSource;
  final MessagesLocalDataSource _localDataSource;
  final WebSocketService _wsService;
  final SyncEngine _syncEngine;

  MessagingRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._wsService,
    this._syncEngine,
  );

  @override
  Stream<List<MessageEntity>> watchMessages(String chatRoomId, {int limit = 30}) {
    // Background sync initial messages
    _remoteDataSource.fetchMessages(chatRoomId, limit: limit).then((messages) {
      _localDataSource.saveMessages(messages);
    }).catchError((_) {});

    return _localDataSource.watchMessages(chatRoomId, limit: limit);
  }

  @override
  Future<Either<ChatFailures, Unit>> sendMessage(
    String chatRoomId,
    String body,
  ) async {
    try {
      final clientMessageId = const Uuid().v4();
      await _syncEngine.enqueueMessage(
        chatRoomId: chatRoomId,
        body: body,
        clientMessageId: clientMessageId,
      );
      return right(unit);
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, List<MessageEntity>>> loadOlderMessages(
    String chatRoomId, {
    required DateTime beforeTimestamp,
    int limit = 30,
  }) async {
    try {
      // 1. Check local DB first
      final localOlder = await _localDataSource.getOlderMessages(
        chatRoomId,
        beforeTimestamp,
        limit: limit,
      );

      if (localOlder.length >= limit) {
        return right(localOlder);
      }

      // 2. Fetch from remote API if local cache doesn't have enough
      final remoteOlder = await _remoteDataSource.fetchMessages(
        chatRoomId,
        cursor: beforeTimestamp,
        limit: limit,
      );

      if (remoteOlder.isNotEmpty) {
        await _localDataSource.saveMessages(remoteOlder);
      }

      // 3. Return merged results from local
      final merged = await _localDataSource.getOlderMessages(
        chatRoomId,
        beforeTimestamp,
        limit: limit,
      );
      return right(merged);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, Unit>> markAsRead(String chatRoomId) async {
    try {
      _wsService.markRead(chatRoomId);
      await _remoteDataSource.markAsRead(chatRoomId);
      return right(unit);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  void sendTyping(String chatRoomId, bool isTyping) {
    _wsService.sendTyping(chatRoomId, isTyping);
  }

  @override
  Stream<Map<String, dynamic>> watchRealtimeEvents() {
    return _wsService.events;
  }

  ChatFailures _mapExceptionToFailure(ChatExceptions e) {
    if (e is NetworkException) {
      return NetworkFailure(message: e.message);
    } else if (e is NotFoundException) {
      return NotFoundFailure(message: e.message);
    } else if (e is ForbiddenException) {
      return ForbiddenFailure(message: e.message);
    } else if (e is UnauthorizedException) {
      return UnauthorizedFailure(message: e.message);
    }
    return ServerFailure(message: e.message);
  }
}
