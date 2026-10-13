// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dao.dart';

// ignore_for_file: type=lint
mixin _$MessageDaoMixin on DatabaseAccessor<AppDatabase> {
  $CachedMessagesTable get cachedMessages => attachedDatabase.cachedMessages;
  $PendingMessagesTable get pendingMessages => attachedDatabase.pendingMessages;
  MessageDaoManager get managers => MessageDaoManager(this);
}

class MessageDaoManager {
  final _$MessageDaoMixin _db;
  MessageDaoManager(this._db);
  $$CachedMessagesTableTableManager get cachedMessages =>
      $$CachedMessagesTableTableManager(
        _db.attachedDatabase,
        _db.cachedMessages,
      );
  $$PendingMessagesTableTableManager get pendingMessages =>
      $$PendingMessagesTableTableManager(
        _db.attachedDatabase,
        _db.pendingMessages,
      );
}
