import '../../domain/entities/user_profile_entity.dart';

abstract class SettingsRemoteDataSource {
  Future<UserProfileEntity?> getCurrentUser();
  Future<void> signOut();
}
