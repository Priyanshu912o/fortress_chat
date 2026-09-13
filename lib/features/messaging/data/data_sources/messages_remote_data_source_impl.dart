import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../models/message_model.dart';
import 'messages_remote_data_source.dart';

@LazySingleton(as: MessagesRemoteDataSource)
class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final ApiClient _client;
  final FirebaseAuth _auth;

  MessagesRemoteDataSourceImpl(this._client, this._auth);

  String? get _currentUid => _auth.currentUser?.uid;

  @override
  Future<List<MessageModel>> fetchMessages(
    String chatRoomId, {
    DateTime? cursor,
    int limit = 30,
  }) async {
    final queryParams = <String, dynamic>{
      'chatRoomId': chatRoomId,
      'limit': limit.toString(),
    };
    if (cursor != null) {
      queryParams['cursor'] = cursor.toIso8601String();
    }

    final response = await _client.get(
      '/api/messages',
      queryParameters: queryParams,
    );

    final list = response.data as List<dynamic>;
    return list
        .map((item) => MessageModel.fromJson(
              item as Map<String, dynamic>,
              currentUid: _currentUid,
            ))
        .toList();
  }

  @override
  Future<MessageModel> sendMessage(
    String chatRoomId,
    String body,
    String clientMessageId,
  ) async {
    final response = await _client.post(
      '/api/messages',
      data: {
        'chatRoomId': chatRoomId,
        'body': body,
        'clientMessageId': clientMessageId,
      },
    );

    return MessageModel.fromJson(
      response.data as Map<String, dynamic>,
      currentUid: _currentUid,
    );
  }

  @override
  Future<Unit> markAsRead(String chatRoomId) async {
    await _client.post(
      '/api/messages/read',
      data: {'chatRoomId': chatRoomId},
    );
    return unit;
  }
}
