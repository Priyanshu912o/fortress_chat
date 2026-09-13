import 'package:fpdart/fpdart.dart';
import '../models/message_model.dart';

abstract class MessagesLocalDataSource {
  Stream<List<MessageModel>> watchMessages(String chatRoomId, {int limit = 30});
  Future<List<MessageModel>> getOlderMessages(
    String chatRoomId,
    DateTime beforeTimestamp, {
    int limit = 30,
  });
  Future<Unit> saveMessages(List<MessageModel> messages);
  Future<Unit> saveMessage(MessageModel message);
}
