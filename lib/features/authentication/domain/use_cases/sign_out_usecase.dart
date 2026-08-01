import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUsecase {
  final AuthRepository _repository;
  SignOutUsecase(this._repository);

  Future<Either<AuthFailures,Unit>> call(){
    return _repository.signOut();
  }
}