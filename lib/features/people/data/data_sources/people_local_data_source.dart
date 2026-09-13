import 'package:fpdart/fpdart.dart';
import '../models/connection_model.dart';

abstract class PeopleLocalDataSource {
  Stream<List<ConnectionModel>> watchAcceptedConnections();
  Stream<List<ConnectionModel>> watchPendingRequests(String currentUid);
  Stream<List<ConnectionModel>> watchSentRequests(String currentUid);
  Future<Unit> saveConnections(List<ConnectionModel> connections);
  Future<Unit> updateConnectionStatus(String id, String status);
  Future<Unit> deleteConnection(String id);
}
