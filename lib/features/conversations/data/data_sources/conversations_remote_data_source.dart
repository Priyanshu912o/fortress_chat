import '../models/chat_room_model.dart';

abstract class ConversationsRemoteDataSource {
  Future<List<ChatRoomModel>> fetchChatRooms();
  Future<ChatRoomModel> getOrCreateDirectChat(String otherUid);
  Future<ChatRoomModel> createGroupChat(String name, List<String> participantUids);
}
