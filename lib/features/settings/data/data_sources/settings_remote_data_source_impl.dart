import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'settings_remote_data_source.dart';

@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseAuth _auth;
  SettingsRemoteDataSourceImpl(this._auth);

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
}
