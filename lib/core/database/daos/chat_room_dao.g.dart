// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_dao.dart';

// ignore_for_file: type=lint
mixin _$ChatRoomDaoMixin on DatabaseAccessor<AppDatabase> {
  $CachedChatRoomsTable get cachedChatRooms => attachedDatabase.cachedChatRooms;
  ChatRoomDaoManager get managers => ChatRoomDaoManager(this);
}

class ChatRoomDaoManager {
  final _$ChatRoomDaoMixin _db;
  ChatRoomDaoManager(this._db);
  $$CachedChatRoomsTableTableManager get cachedChatRooms =>
      $$CachedChatRoomsTableTableManager(
        _db.attachedDatabase,
        _db.cachedChatRooms,
      );
}
