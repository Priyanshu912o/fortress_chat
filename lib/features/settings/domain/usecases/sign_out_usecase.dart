import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repositories/settings_repository.dart';

@lazySingleton
class SignOutUsecase {
  final SettingsRepository _repository;
  const SignOutUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call() {
    return _repository.signOut();
  }
}
