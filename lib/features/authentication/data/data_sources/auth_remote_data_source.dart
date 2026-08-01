import 'package:Fortress/features/authentication/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRemoteDataSource {
  Stream<UserEntity?> get userChanges;
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(
    String email,
    String password,
    String name,
  );
  Future<Unit> verifyEmail();
  Future<Unit> checkEmailVerification();
  Future<Unit> signOut();
  Future<Unit> sendResetPasswordEmail(String email);
  Future<Unit> resetPasword(String newPassword,String oobCode);
  Future<UserEntity?> getCurrentUser();
}
