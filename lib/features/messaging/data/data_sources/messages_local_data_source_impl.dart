import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../models/message_model.dart';
import 'messages_local_data_source.dart';

@LazySingleton(as: MessagesLocalDataSource)
class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  final AppDatabase _db;

  MessagesLocalDataSourceImpl(this._db);

  @override
  Stream<List<MessageModel>> watchMessages(String chatRoomId, {int limit = 30}) {
    return _db.messageDao
        .watchMessages(chatRoomId, limit: limit)
        .map((list) => list.map(MessageModel.fromDrift).toList());
  }

  @override
  Future<List<MessageModel>> getOlderMessages(
    String chatRoomId,
    DateTime beforeTimestamp, {
    int limit = 30,
  }) async {
    final list = await _db.messageDao.getOlderThan(
      chatRoomId,
      beforeTimestamp,
      limit: limit,
    );
    return list.map(MessageModel.fromDrift).toList();
  }

  @override
  Future<Unit> saveMessages(List<MessageModel> messages) async {
    final companions = messages.map((m) => m.toDrift()).toList();
    await _db.messageDao.insertBatch(companions);
    return unit;
  }

  @override
  Future<Unit> saveMessage(MessageModel message) async {
    await _db.messageDao.upsertMessage(message.toDrift());
    return unit;
  }
}
