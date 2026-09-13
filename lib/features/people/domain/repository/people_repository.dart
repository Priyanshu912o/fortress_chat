import 'package:fpdart/fpdart.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/connection_entity.dart';
import '../entities/contact_profile_entity.dart';

abstract class PeopleRepository {
  Stream<List<ConnectionEntity>> watchAcceptedConnections();
  Stream<List<ConnectionEntity>> watchPendingRequests();
  Stream<List<ConnectionEntity>> watchSentRequests();

  Future<Either<ChatFailures, List<ContactProfileEntity>>> searchUserByEmail(String email);
  Future<Either<ChatFailures, ConnectionEntity>> sendConnectionRequest(String toUid);
  Future<Either<ChatFailures, String>> acceptConnectionRequest(String id);
  Future<Either<ChatFailures, Unit>> rejectConnectionRequest(String id);
  Future<Either<ChatFailures, Unit>> syncConnections();
}
