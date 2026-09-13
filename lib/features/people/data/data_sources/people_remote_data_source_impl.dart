import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../models/connection_model.dart';
import '../models/contact_profile_model.dart';
import 'people_remote_data_source.dart';

@LazySingleton(as: PeopleRemoteDataSource)
class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final ApiClient _client;
  final FirebaseAuth _auth;

  PeopleRemoteDataSourceImpl(this._client, this._auth);

  String? get _currentUid => _auth.currentUser?.uid;

  @override
  Future<List<ContactProfileModel>> searchUserByEmail(String email) async {
    final response = await _client.get(
      '/api/users/search',
      queryParameters: {'email': email},
    );

    final list = response.data as List<dynamic>;
    return list
        .map((item) => ContactProfileModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ConnectionModel> sendConnectionRequest(String toUid) async {
    final response = await _client.post(
      '/api/connections',
      data: {'toUid': toUid},
    );

    return ConnectionModel.fromJson(
      response.data as Map<String, dynamic>,
      currentUid: _currentUid,
    );
  }

  @override
  Future<String> acceptConnectionRequest(String id) async {
    final response = await _client.patch(
      '/api/connections/$id/accept',
      data: const <String, dynamic>{},
    );
    final data = response.data as Map<String, dynamic>;
    return data['chatRoomId'] as String;
  }

  @override
  Future<Unit> rejectConnectionRequest(String id) async {
    await _client.patch(
      '/api/connections/$id/reject',
      data: const <String, dynamic>{},
    );
    return unit;
  }

  @override
  Future<List<ConnectionModel>> fetchAcceptedConnections() async {
    final response = await _client.get('/api/connections');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => ConnectionModel.fromJson(
              item as Map<String, dynamic>,
              currentUid: _currentUid,
            ))
        .toList();
  }

  @override
  Future<List<ConnectionModel>> fetchPendingRequests() async {
    final response = await _client.get('/api/connections/pending');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => ConnectionModel.fromJson(
              item as Map<String, dynamic>,
              currentUid: _currentUid,
            ))
        .toList();
  }

  @override
  Future<List<ConnectionModel>> fetchSentRequests() async {
    final response = await _client.get('/api/connections/sent');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => ConnectionModel.fromJson(
              item as Map<String, dynamic>,
              currentUid: _currentUid,
            ))
        .toList();
  }
}
