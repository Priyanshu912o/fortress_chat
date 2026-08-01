import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPaswordUsecase {
  final AuthRepository _repository;
  ResetPaswordUsecase(this._repository);

  Future<Either<AuthFailures, Unit>> call(String newPassword,String oobCode){
    return _repository.resetPassword(newPassword,oobCode);
  }
}