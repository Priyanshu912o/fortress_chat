import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckEmailVerificationUsecase {
  final AuthRepository _repository;
  CheckEmailVerificationUsecase(this._repository);

  Future<Either<AuthFailures,bool>> call(){
    return _repository.checkEmailVerification();
  }
}