import 'package:fpdart/fpdart.dart';
import '../models/connection_model.dart';
import '../models/contact_profile_model.dart';

abstract class PeopleRemoteDataSource {
  Future<List<ContactProfileModel>> searchUserByEmail(String email);
  Future<ConnectionModel> sendConnectionRequest(String toUid);
  Future<String> acceptConnectionRequest(String id);
  Future<Unit> rejectConnectionRequest(String id);
  Future<List<ConnectionModel>> fetchAcceptedConnections();
  Future<List<ConnectionModel>> fetchPendingRequests();
  Future<List<ConnectionModel>> fetchSentRequests();
}
