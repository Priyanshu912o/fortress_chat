import 'package:fpdart/fpdart.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/chat_room.dart';

abstract class ConversationsRepository {
  Stream<List<ChatRoom>> watchChatRooms();
  Future<Either<ChatFailures, ChatRoom>> getOrCreateDirectChat(String otherUid);
  Future<Either<ChatFailures, ChatRoom>> createGroupChat(
    String name,
    List<String> participantUids,
  );
  Future<Either<ChatFailures, Unit>> syncChatRooms();
}
