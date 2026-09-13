import 'package:fpdart/fpdart.dart';
import '../models/message_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<MessageModel>> fetchMessages(
    String chatRoomId, {
    DateTime? cursor,
    int limit = 30,
  });
  Future<MessageModel> sendMessage(
    String chatRoomId,
    String body,
    String clientMessageId,
  );
  Future<Unit> markAsRead(String chatRoomId);
}
