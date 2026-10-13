import 'package:drift/drift.dart';
import '../app_database.dart';

part 'connection_dao.g.dart';

@DriftAccessor(tables: [CachedConnections])
class ConnectionDao extends DatabaseAccessor<AppDatabase> with _$ConnectionDaoMixin {
  ConnectionDao(super.db);

  Stream<List<CachedConnection>> watchAcceptedConnections() {
    return (select(cachedConnections)
          ..where((tbl) => tbl.status.equals('ACCEPTED'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]))
        .watch();
  }

  Stream<List<CachedConnection>> watchPendingRequests(String currentUid) {
    return (select(cachedConnections)
          ..where((tbl) =>
              tbl.toUid.equals(currentUid) & tbl.status.equals('PENDING'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Stream<List<CachedConnection>> watchSentRequests(String currentUid) {
    return (select(cachedConnections)
          ..where((tbl) =>
              tbl.fromUid.equals(currentUid) & tbl.status.equals('PENDING'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<List<CachedConnection>> getAcceptedConnections() {
    return (select(cachedConnections)
          ..where((tbl) => tbl.status.equals('ACCEPTED'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]))
        .get();
  }

  Future<void> upsertConnection(CachedConnectionsCompanion conn) async {
    await into(cachedConnections).insertOnConflictUpdate(conn);
  }

  Future<void> insertBatch(List<CachedConnectionsCompanion> conns) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(cachedConnections, conns);
    });
  }

  Future<void> updateStatus(String id, String status) async {
    await (update(cachedConnections)..where((tbl) => tbl.id.equals(id))).write(
      CachedConnectionsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteConnection(String id) async {
    await (delete(cachedConnections)..where((tbl) => tbl.id.equals(id))).go();
  }
}
