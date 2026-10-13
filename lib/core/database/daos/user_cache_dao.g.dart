// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cache_dao.dart';

// ignore_for_file: type=lint
mixin _$UserCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $CachedUsersTable get cachedUsers => attachedDatabase.cachedUsers;
  UserCacheDaoManager get managers => UserCacheDaoManager(this);
}

class UserCacheDaoManager {
  final _$UserCacheDaoMixin _db;
  UserCacheDaoManager(this._db);
  $$CachedUsersTableTableManager get cachedUsers =>
      $$CachedUsersTableTableManager(_db.attachedDatabase, _db.cachedUsers);
}
