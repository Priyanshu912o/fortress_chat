import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_exceptions.dart';
import '../../../../core/components/chat_failures.dart';
import '../../domain/entities/connection_entity.dart';
import '../../domain/entities/contact_profile_entity.dart';
import '../../domain/repository/people_repository.dart';
import '../data_sources/people_local_data_source.dart';
import '../data_sources/people_remote_data_source.dart';

@LazySingleton(as: PeopleRepository)
class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource _remoteDataSource;
  final PeopleLocalDataSource _localDataSource;
  final FirebaseAuth _auth;

  PeopleRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._auth,
  );

  String get _currentUid => _auth.currentUser?.uid ?? '';

  @override
  Stream<List<ConnectionEntity>> watchAcceptedConnections() {
    return _localDataSource.watchAcceptedConnections();
  }

  @override
  Stream<List<ConnectionEntity>> watchPendingRequests() {
    return _localDataSource.watchPendingRequests(_currentUid);
  }

  @override
  Stream<List<ConnectionEntity>> watchSentRequests() {
    return _localDataSource.watchSentRequests(_currentUid);
  }

  @override
  Future<Either<ChatFailures, List<ContactProfileEntity>>> searchUserByEmail(
    String email,
  ) async {
    try {
      final results = await _remoteDataSource.searchUserByEmail(email);
      return right(results);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, ConnectionEntity>> sendConnectionRequest(
    String toUid,
  ) async {
    try {
      final connection = await _remoteDataSource.sendConnectionRequest(toUid);
      await _localDataSource.saveConnections([connection]);
      return right(connection);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, String>> acceptConnectionRequest(String id) async {
    try {
      final chatRoomId = await _remoteDataSource.acceptConnectionRequest(id);
      await _localDataSource.updateConnectionStatus(id, 'ACCEPTED');
      return right(chatRoomId);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, Unit>> rejectConnectionRequest(String id) async {
    try {
      await _remoteDataSource.rejectConnectionRequest(id);
      await _localDataSource.updateConnectionStatus(id, 'REJECTED');
      return right(unit);
    } on ChatExceptions catch (e) {
      return left(_mapExceptionToFailure(e));
    } catch (e) {
      return left(UnknownChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ChatFailures, Unit>> syncConnections() async {
    try {
      final accepted = await _remoteDataSource.fetchAcceptedConnections();
      final pending = await _remoteDataSource.fetchPendingRequests();
      final sent = await _remoteDataSource.fetchSentRequests();

      await _localDataSource.saveConnections([...accepted, ...pending, ...sent]);
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
