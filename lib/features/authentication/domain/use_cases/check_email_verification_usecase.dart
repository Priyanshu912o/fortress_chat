import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckEmailVerificationUsecase {
  final AuthRepository _repository;
  CheckEmailVerificationUsecase(this._repository);

  Future<Either<AuthFailures,Unit>> call(){
    return _repository.checkEmailVerification();
  }
}