import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/features/authentication/domain/entities/user_entity.dart';
import 'package:Fortress/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUsecase {
  final AuthRepository _repository;
  SignUpUsecase(this._repository);

  Future<Either<AuthFailures, UserEntity>> call(
    String name,
    String email,
    String password,
  ) {
    return _repository.signUp(name, email, password);
  }
}
