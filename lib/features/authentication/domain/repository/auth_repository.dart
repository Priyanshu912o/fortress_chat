import 'dart:async';

import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/entities/user_entity.dart';
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
  Future<Either<AuthFailures, Unit>> forgotPassword(String email);
  Future<Either<AuthFailures, bool>> checkEmailVerification();
  Future<Either<AuthFailures, Unit>> signOut();
}
