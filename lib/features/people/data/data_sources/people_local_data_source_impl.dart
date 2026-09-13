import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../models/connection_model.dart';
import 'people_local_data_source.dart';

@LazySingleton(as: PeopleLocalDataSource)
class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
  final AppDatabase _db;

  PeopleLocalDataSourceImpl(this._db);

  @override
  Stream<List<ConnectionModel>> watchAcceptedConnections() {
    return _db.connectionDao
        .watchAcceptedConnections()
        .map((list) => list.map(ConnectionModel.fromDrift).toList());
  }

  @override
  Stream<List<ConnectionModel>> watchPendingRequests(String currentUid) {
    return _db.connectionDao
        .watchPendingRequests(currentUid)
        .map((list) => list.map(ConnectionModel.fromDrift).toList());
  }

  @override
  Stream<List<ConnectionModel>> watchSentRequests(String currentUid) {
    return _db.connectionDao
        .watchSentRequests(currentUid)
        .map((list) => list.map(ConnectionModel.fromDrift).toList());
  }

  @override
  Future<Unit> saveConnections(List<ConnectionModel> connections) async {
    final companions = connections.map((c) => c.toDrift()).toList();
    await _db.connectionDao.insertBatch(companions);
    return unit;
  }

  @override
  Future<Unit> updateConnectionStatus(String id, String status) async {
    await _db.connectionDao.updateStatus(id, status);
    return unit;
  }

  @override
  Future<Unit> deleteConnection(String id) async {
    await _db.connectionDao.deleteConnection(id);
    return unit;
  }
}
