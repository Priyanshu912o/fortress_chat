import 'dart:async';

import 'package:Fortress/core/components/app_exceptions.dart';
import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/core/utils/map_firebase_exception_to_auth_failure.dart';
import 'package:Fortress/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:Fortress/features/authentication/domain/entities/user_entity.dart';
import 'package:Fortress/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteAuth;

  AuthRepositoryImpl({required this._remoteAuth});

  @override
  Future<Either<AuthFailures, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await _remoteAuth.signIn(email, password);
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, UserEntity>> signUp(
    String email,
    String name,
    String password,
  ) async {
    try {
      final result = await _remoteAuth.signUp(email, name, password);
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> signOut() async {
    try {
      final result = await _remoteAuth.signOut();
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> checkEmailVerification() async {
    try {
      await _remoteAuth.checkEmailVerification();
      return const Right(unit);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> sendResetPasswordEmail(
    String email,
  ) async {
    try {
      final result = await _remoteAuth.sendResetPasswordEmail(email);
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> resetPassword(
    String newPassword,
    String oobCode,
  ) async {
    try {
      final result = await _remoteAuth.resetPasword(newPassword, oobCode);
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> verifyEmail() async {
    try {
      final result = await _remoteAuth.verifyEmail();
      return Right(result);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges => _remoteAuth.userChanges;

  @override
  Future<Either<AuthFailures, UserEntity?>> getCurrentUser() async {
    try {
      final user = await _remoteAuth.getCurrentUser();
      return Right(user);
    } on AuthExceptions catch (e) {
      return Left(mapFromFirebaseAuthExceptionToAuthFailure(e));
    }
  }
}
