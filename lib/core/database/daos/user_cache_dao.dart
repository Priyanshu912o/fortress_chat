import 'package:drift/drift.dart';
import '../app_database.dart';

part 'user_cache_dao.g.dart';

@DriftAccessor(tables: [CachedUsers])
class UserCacheDao extends DatabaseAccessor<AppDatabase> with _$UserCacheDaoMixin {
  UserCacheDao(super.db);

  Future<CachedUser?> getUser(String uid) {
    return (select(cachedUsers)..where((tbl) => tbl.uid.equals(uid)))
        .getSingleOrNull();
  }

  Stream<CachedUser?> watchUser(String uid) {
    return (select(cachedUsers)..where((tbl) => tbl.uid.equals(uid)))
        .watchSingleOrNull();
  }

  Future<void> upsertUser(CachedUsersCompanion user) async {
    await into(cachedUsers).insertOnConflictUpdate(user);
  }

  Future<void> insertBatch(List<CachedUsersCompanion> users) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(cachedUsers, users);
    });
  }

  Future<void> updatePresence(String uid, bool isOnline, DateTime lastSeen) async {
    await (update(cachedUsers)..where((tbl) => tbl.uid.equals(uid))).write(
      CachedUsersCompanion(
        isOnline: Value(isOnline),
        lastSeen: Value(lastSeen),
      ),
    );
  }

  Future<List<CachedUser>> searchUsers(String query) {
    return (select(cachedUsers)
          ..where((tbl) =>
              tbl.name.like('%$query%') | tbl.email.like('%$query%')))
        .get();
  }
}
