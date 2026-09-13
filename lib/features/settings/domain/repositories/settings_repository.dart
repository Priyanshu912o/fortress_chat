import 'package:fpdart/fpdart.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/user_profile_entity.dart';

abstract class SettingsRepository {
  Future<Either<ChatFailures, UserProfileEntity?>> getCurrentUser();
  Future<Either<ChatFailures, Unit>> clearLocalCache();
  Future<Either<ChatFailures, Unit>> signOut();
}
