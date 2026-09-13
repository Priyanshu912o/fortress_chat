import 'package:fpdart/fpdart.dart';
import '../models/chat_room_model.dart';

abstract class ConversationsLocalDataSource {
  Stream<List<ChatRoomModel>> watchChatRooms();
  Future<Unit> saveChatRooms(List<ChatRoomModel> rooms);
  Future<Unit> saveChatRoom(ChatRoomModel room);
  Future<ChatRoomModel?> getChatRoom(String id);
}
