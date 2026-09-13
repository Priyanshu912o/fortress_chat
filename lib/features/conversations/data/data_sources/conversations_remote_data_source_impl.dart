import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../models/chat_room_model.dart';
import 'conversations_remote_data_source.dart';

@LazySingleton(as: ConversationsRemoteDataSource)
class ConversationsRemoteDataSourceImpl implements ConversationsRemoteDataSource {
  final ApiClient _client;
  final FirebaseAuth _auth;

  ConversationsRemoteDataSourceImpl(this._client, this._auth);

  String? get _currentUid => _auth.currentUser?.uid;

  @override
  Future<List<ChatRoomModel>> fetchChatRooms() async {
    final response = await _client.get('/api/chat-rooms');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => ChatRoomModel.fromJson(
              item as Map<String, dynamic>,
              currentUid: _currentUid,
            ))
        .toList();
  }

  @override
  Future<ChatRoomModel> getOrCreateDirectChat(String otherUid) async {
    final response = await _client.post(
      '/api/chat-rooms/direct',
      data: {'otherUid': otherUid},
    );
    return ChatRoomModel.fromJson(
      response.data as Map<String, dynamic>,
      currentUid: _currentUid,
    );
  }

  @override
  Future<ChatRoomModel> createGroupChat(
    String name,
    List<String> participantUids,
  ) async {
    final response = await _client.post(
      '/api/chat-rooms/group',
      data: {
        'name': name,
        'participantUids': participantUids,
      },
    );
    return ChatRoomModel.fromJson(
      response.data as Map<String, dynamic>,
      currentUid: _currentUid,
    );
  }
}
