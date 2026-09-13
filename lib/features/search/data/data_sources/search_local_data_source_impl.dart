import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../../../conversations/data/models/chat_room_model.dart';
import '../../../messaging/data/models/message_model.dart';
import '../../../people/data/models/connection_model.dart';
import '../../domain/entities/search_result_entity.dart';
import 'search_local_data_source.dart';

@LazySingleton(as: SearchLocalDataSource)
class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final AppDatabase _db;
  SearchLocalDataSourceImpl(this._db);

  @override
  Future<SearchResultEntity> searchAll(String query) async {
    final lowerQuery = query.toLowerCase();

    // 1. Search Chat Rooms
    final allRooms = await _db.chatRoomDao.getChatRooms();
    final matchingRooms = allRooms
        .map(ChatRoomModel.fromDrift)
        .where((room) =>
            room.displayName.toLowerCase().contains(lowerQuery) ||
            (room.lastMessageBody ?? '').toLowerCase().contains(lowerQuery))
        .toList();

    // 2. Search Messages
    final matchingDbMessages = await (_db.select(_db.cachedMessages)
          ..where((tbl) => tbl.body.like('%$lowerQuery%'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.sentAt)])
          ..limit(20))
        .get();
    final matchingMessages =
        matchingDbMessages.map(MessageModel.fromDrift).toList();

    // 3. Search Contacts
    final allContacts = await _db.connectionDao.getAcceptedConnections();
    final matchingContacts = allContacts
        .map(ConnectionModel.fromDrift)
        .where((c) =>
            c.otherName.toLowerCase().contains(lowerQuery) ||
            c.otherEmail.toLowerCase().contains(lowerQuery))
        .toList();

    return SearchResultEntity(
      rooms: matchingRooms,
      messages: matchingMessages,
      contacts: matchingContacts,
    );
  }
}
