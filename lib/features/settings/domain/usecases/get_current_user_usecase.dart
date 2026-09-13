import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/settings_repository.dart';

@lazySingleton
class GetCurrentUserUsecase {
  final SettingsRepository _repository;
  const GetCurrentUserUsecase(this._repository);

  Future<Either<ChatFailures, UserProfileEntity?>> call() {
    return _repository.getCurrentUser();
  }
}
