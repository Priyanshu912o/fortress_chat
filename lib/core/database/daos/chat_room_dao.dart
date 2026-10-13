import 'package:drift/drift.dart';
import '../app_database.dart';

part 'chat_room_dao.g.dart';

@DriftAccessor(tables: [CachedChatRooms])
class ChatRoomDao extends DatabaseAccessor<AppDatabase> with _$ChatRoomDaoMixin {
  ChatRoomDao(super.db);

  Stream<List<CachedChatRoom>> watchChatRooms() {
    return (select(cachedChatRooms)
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.lastMessageAt),
            (tbl) => OrderingTerm.desc(tbl.createdAt),
          ]))
        .watch();
  }

  Future<List<CachedChatRoom>> getChatRooms() {
    return (select(cachedChatRooms)
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.lastMessageAt),
            (tbl) => OrderingTerm.desc(tbl.createdAt),
          ]))
        .get();
  }

  Future<CachedChatRoom?> getChatRoom(String id) {
    return (select(cachedChatRooms)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertChatRoom(CachedChatRoomsCompanion room) async {
    await into(cachedChatRooms).insertOnConflictUpdate(room);
  }

  Future<void> insertBatch(List<CachedChatRoomsCompanion> rooms) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(cachedChatRooms, rooms);
    });
  }

  Future<void> updateLastMessage(
    String roomId,
    String body,
    DateTime at,
    String senderId,
  ) async {
    await (update(cachedChatRooms)..where((tbl) => tbl.id.equals(roomId))).write(
      CachedChatRoomsCompanion(
        lastMessageBody: Value(body),
        lastMessageAt: Value(at),
        lastSenderId: Value(senderId),
      ),
    );
  }

  Future<void> resetUnreadCount(String roomId) async {
    await (update(cachedChatRooms)..where((tbl) => tbl.id.equals(roomId))).write(
      const CachedChatRoomsCompanion(
        unreadCount: Value(0),
      ),
    );
  }

  Future<void> incrementUnreadCount(String roomId) async {
    final room = await getChatRoom(roomId);
    if (room != null) {
      await (update(cachedChatRooms)..where((tbl) => tbl.id.equals(roomId))).write(
        CachedChatRoomsCompanion(
          unreadCount: Value(room.unreadCount + 1),
        ),
      );
    }
  }
}
