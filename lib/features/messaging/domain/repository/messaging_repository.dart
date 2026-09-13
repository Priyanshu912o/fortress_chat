import 'package:fpdart/fpdart.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/message_entity.dart';

abstract class MessagingRepository {
  Stream<List<MessageEntity>> watchMessages(String chatRoomId, {int limit = 30});
  Future<Either<ChatFailures, Unit>> sendMessage(String chatRoomId, String body);
  Future<Either<ChatFailures, List<MessageEntity>>> loadOlderMessages(
    String chatRoomId, {
    required DateTime beforeTimestamp,
    int limit = 30,
  });
  Future<Either<ChatFailures, Unit>> markAsRead(String chatRoomId);
  void sendTyping(String chatRoomId, bool isTyping);
  Stream<Map<String, dynamic>> watchRealtimeEvents();
}
