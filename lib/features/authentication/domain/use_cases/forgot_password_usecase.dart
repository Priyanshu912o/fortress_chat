import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ForgotPasswordUsecase {
  final AuthRepository _repository;
  ForgotPasswordUsecase(this._repository);

  Future<Either<AuthFailures,Unit>> call(String email){
    return _repository.forgotPassword(email);
  }
}