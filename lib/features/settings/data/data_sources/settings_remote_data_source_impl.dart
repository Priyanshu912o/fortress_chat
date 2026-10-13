import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'settings_remote_data_source.dart';

@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseAuth _auth;
  final ApiClient _apiClient;

  SettingsRemoteDataSourceImpl(this._auth, this._apiClient);

  @override
  Future<UserProfileEntity?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserProfileEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    // 1. Delete on backend (anonymizes user and frees email in PostgreSQL)
    await _apiClient.delete('/api/users/me');

    // 2. Delete user from Firebase Auth
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
      } catch (_) {
        // If deletion requires recent login, sign out
        await _auth.signOut();
      }
    }
  }
}
