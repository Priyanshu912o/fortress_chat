import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'daos/message_dao.dart';
import 'daos/chat_room_dao.dart';
import 'daos/connection_dao.dart';
import 'daos/user_cache_dao.dart';

part 'app_database.g.dart';

// Tables definition
class CachedUsers extends Table {
  TextColumn get uid => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get dpUrl => text().nullable()();
  BoolColumn get isOnline => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSeen => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {uid};
}

class CachedConnections extends Table {
  TextColumn get id => text()();
  TextColumn get fromUid => text()();
  TextColumn get toUid => text()();
  TextColumn get status => text()(); // PENDING, ACCEPTED, REJECTED, BLOCKED
  TextColumn get otherUid => text()();
  TextColumn get otherName => text()();
  TextColumn get otherEmail => text()();
  TextColumn get otherDpUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedChatRooms extends Table {
  TextColumn get id => text()();
  BoolColumn get isDirect => boolean().withDefault(const Constant(true))();
  TextColumn get groupName => text().nullable()();
  TextColumn get groupDpUrl => text().nullable()();
  TextColumn get lastMessageBody => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  TextColumn get lastSenderId => text().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  TextColumn get participantUids => text()(); // comma-separated UIDs
  TextColumn get otherUserName => text().nullable()(); // display title for 1:1
  TextColumn get otherUserDpUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedMessages extends Table {
  TextColumn get id => text()(); // clientMessageId or serverMessageId
  TextColumn get clientMessageId => text()();
  TextColumn get serverMessageId => text().nullable()();
  TextColumn get chatRoomId => text()();
  TextColumn get senderId => text()();
  TextColumn get senderName => text().nullable()();
  TextColumn get body => text()();
  DateTimeColumn get sentAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('sent'))(); // pending, sending, sent, delivered, read, failed
  BoolColumn get isMe => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class PendingMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientMessageId => text().unique()();
  TextColumn get chatRoomId => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, sending, failed
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fortress_chat.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    CachedUsers,
    CachedConnections,
    CachedChatRooms,
    CachedMessages,
    PendingMessages,
  ],
  daos: [
    MessageDao,
    ChatRoomDao,
    ConnectionDao,
    UserCacheDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(cachedMessages).go();
      await delete(pendingMessages).go();
      await delete(cachedChatRooms).go();
      await delete(cachedConnections).go();
      await delete(cachedUsers).go();
    });
  }
}
