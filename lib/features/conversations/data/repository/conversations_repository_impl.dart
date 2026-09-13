import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_exceptions.dart';
import '../../../../core/components/chat_failures.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repository/conversations_repository.dart';
import '../data_sources/conversations_local_data_source.dart';
import '../data_sources/conversations_remote_data_source.dart';

@LazySingleton(as: ConversationsRepository)
class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsRemoteDataSource _remoteDataSource;
  final ConversationsLocalDataSource _localDataSource;

  ConversationsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Stream<List<ChatRoom>> watchChatRooms() {
    return _localDataSource.watchChatRooms();
  }

  @override
  Future<Either<ChatFailures, ChatRoom>> getOrCreateDirectChat(String otherUid) async {
    try {
      final room = await _remoteDataSource.getOrCreateDirectChat(otherUid);
      await _localDataSource.saveChatRoom(room);
      return right(room);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, ChatRoom>> createGroupChat(
    String name,
    List<String> participantUids,
  ) async {
    try {
      final room = await _remoteDataSource.createGroupChat(name, participantUids);
      await _localDataSource.saveChatRoom(room);
      return right(room);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, Unit>> syncChatRooms() async {
    try {
      final rooms = await _remoteDataSource.fetchChatRooms();
      await _localDataSource.saveChatRooms(rooms);
      return right(unit);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
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
    } else if (e is ValidationException) {
      return ValidationFailure(message: e.message);
    }
    return ServerFailure(message: e.message);
  }
}
