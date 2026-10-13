import 'package:drift/drift.dart';
import '../app_database.dart';

part 'message_dao.g.dart';

@DriftAccessor(tables: [CachedMessages, PendingMessages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  Stream<List<CachedMessage>> watchMessages(String chatRoomId, {int limit = 30}) {
    return (select(cachedMessages)
          ..where((tbl) => tbl.chatRoomId.equals(chatRoomId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.sentAt)])
          ..limit(limit))
        .watch();
  }

  Future<List<CachedMessage>> getMessages(String chatRoomId, {int limit = 30}) {
    return (select(cachedMessages)
          ..where((tbl) => tbl.chatRoomId.equals(chatRoomId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.sentAt)])
          ..limit(limit))
        .get();
  }

  Future<List<CachedMessage>> getOlderThan(
    String chatRoomId,
    DateTime beforeTimestamp, {
    int limit = 30,
  }) {
    return (select(cachedMessages)
          ..where((tbl) =>
              tbl.chatRoomId.equals(chatRoomId) &
              tbl.sentAt.isSmallerThanValue(beforeTimestamp))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.sentAt)])
          ..limit(limit))
        .get();
  }

  Future<void> upsertMessage(CachedMessagesCompanion message) async {
    await into(cachedMessages).insertOnConflictUpdate(message);
  }

  Future<void> insertBatch(List<CachedMessagesCompanion> messages) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(cachedMessages, messages);
    });
  }

  Future<void> updateMessageStatus(
    String clientMessageId,
    String status, {
    String? serverMessageId,
  }) async {
    await (update(cachedMessages)
          ..where((tbl) => tbl.clientMessageId.equals(clientMessageId)))
        .write(
      CachedMessagesCompanion(
        status: Value(status),
        serverMessageId:
            serverMessageId != null ? Value(serverMessageId) : const Value.absent(),
      ),
    );
  }

  // Pending Messages Outbox
  Future<void> insertPendingMessage(PendingMessagesCompanion pending) async {
    await into(pendingMessages).insertOnConflictUpdate(pending);
  }

  Future<List<PendingMessage>> getPendingMessages() {
    return (select(pendingMessages)
          ..where((tbl) => tbl.status.isIn(['pending', 'failed']))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .get();
  }

  Future<void> deletePendingMessage(String clientMessageId) async {
    await (delete(pendingMessages)
          ..where((tbl) => tbl.clientMessageId.equals(clientMessageId)))
        .go();
  }

  Future<void> updatePendingStatus(
    String clientMessageId,
    String status, {
    String? error,
  }) async {
    await (update(pendingMessages)
          ..where((tbl) => tbl.clientMessageId.equals(clientMessageId)))
        .write(
      PendingMessagesCompanion(
        status: Value(status),
        lastError: Value(error),
        retryCount: status == 'failed'
            ? const Value.absent()
            : const Value.absent(),
      ),
    );
  }
}
