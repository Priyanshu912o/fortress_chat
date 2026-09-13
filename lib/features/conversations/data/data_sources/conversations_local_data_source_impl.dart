import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../models/chat_room_model.dart';
import 'conversations_local_data_source.dart';

@LazySingleton(as: ConversationsLocalDataSource)
class ConversationsLocalDataSourceImpl implements ConversationsLocalDataSource {
  final AppDatabase _db;

  ConversationsLocalDataSourceImpl(this._db);

  @override
  Stream<List<ChatRoomModel>> watchChatRooms() {
    return _db.chatRoomDao
        .watchChatRooms()
        .map((list) => list.map(ChatRoomModel.fromDrift).toList());
  }

  @override
  Future<Unit> saveChatRooms(List<ChatRoomModel> rooms) async {
    final companions = rooms.map((r) => r.toDrift()).toList();
    await _db.chatRoomDao.insertBatch(companions);
    return unit;
  }

  @override
  Future<Unit> saveChatRoom(ChatRoomModel room) async {
    await _db.chatRoomDao.upsertChatRoom(room.toDrift());
    return unit;
  }

  @override
  Future<ChatRoomModel?> getChatRoom(String id) async {
    final cached = await _db.chatRoomDao.getChatRoom(id);
    if (cached == null) return null;
    return ChatRoomModel.fromDrift(cached);
  }
}
