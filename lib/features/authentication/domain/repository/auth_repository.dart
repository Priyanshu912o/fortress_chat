import 'dart:async';

import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/features/authentication/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  Future<Either<AuthFailures, UserEntity>> signIn(
    String email,
    String password,
  );
  Future<Either<AuthFailures, UserEntity>> signUp(
    String name,
    String email,
    String password,
  );
  Future<Either<AuthFailures, Unit>> verifyEmail();
  Future<Either<AuthFailures, Unit>> sendResetPasswordEmail(String email);
  Future<Either<AuthFailures, Unit>> resetPassword(String newPassword,String oobCode);
  Future<Either<AuthFailures, Unit>> checkEmailVerification();
  Future<Either<AuthFailures, Unit>> signOut();
  Future<Either<AuthFailures, UserEntity?>> getCurrentUser();
}
