// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_dao.dart';

// ignore_for_file: type=lint
mixin _$ConnectionDaoMixin on DatabaseAccessor<AppDatabase> {
  $CachedConnectionsTable get cachedConnections =>
      attachedDatabase.cachedConnections;
  ConnectionDaoManager get managers => ConnectionDaoManager(this);
}

class ConnectionDaoManager {
  final _$ConnectionDaoMixin _db;
  ConnectionDaoManager(this._db);
  $$CachedConnectionsTableTableManager get cachedConnections =>
      $$CachedConnectionsTableTableManager(
        _db.attachedDatabase,
        _db.cachedConnections,
      );
}
