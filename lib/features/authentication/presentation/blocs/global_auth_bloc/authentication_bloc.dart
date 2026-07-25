import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/entities/user_entity.dart';
import 'package:fortress_chat/features/authentication/domain/repository/auth_repository.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/check_email_verification_usecase.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/forgot_password_usecase.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/sign_out_usecase.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/verify_email_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@lazySingleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CheckEmailVerificationUsecase _checkEmailVerification;
  final VerifyEmailUsecase _verifyEmail;
  final ForgotPasswordUsecase _forgotPassword;
  final SignOutUsecase _signOut;
  late final StreamSubscription<UserEntity?> _authStreamSubscription;
  final AuthRepository _repository;

  AuthenticationBloc({
    required this._checkEmailVerification,
    required this._verifyEmail,
    required this._forgotPassword,
    required this._signOut,
    required this._repository,
  }) : super(AuthInitialState()) {
    _authStreamSubscription = _repository.authStateChanges.listen((user) {
      add(AuthUserChanged(user: user));
    });

    on<AuthenticationEvent>((event, emit) async {
      switch (event) {
        case AuthUserChanged():
          if (event.user == null) {
            emit(UnAuthenticatedState());
          } else {
            emit(AuthenticatedState(user: event.user!));
          }
          break;
        case SignOutEvent():
          final Either<AuthFailures, Unit> result = await _signOut();
          result.fold(
            (failure) {
              emit(AuthErrorState(failure: failure));
            },
            (user) {
              emit(UnAuthenticatedState());
            },
          );
          break;
        case ForgotPasswordEvent():
          final Either<AuthFailures, Unit> result = await _forgotPassword(
            event.email,
          );
          result.fold(
            (failure) {
              emit(AuthErrorState(failure: failure));
            },
            (unit) {
              EmailSentState();
            },
          );

        case VerifyEmail():
        case SendRecoveryEmailEvent():
      }
    });
  }
  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}
