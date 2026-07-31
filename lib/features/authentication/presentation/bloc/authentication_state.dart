part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  @override
  List get props => [];
}

final class AuthInitialState extends AuthenticationState {}

final class AuthenticatedState extends AuthenticationState {
  final UserEntity user;

  AuthenticatedState({required this.user});

  @override
  List get props => [user];
}

final class LoadingState extends AuthenticationState {}

final class ResetPasswordEmailSentState extends AuthenticationState {}

final class NewPasswordSetState extends AuthenticationState {}

final class UnAuthenticatedState extends AuthenticationState {}

final class AuthErrorState extends AuthenticationState {
  final AuthFailures failure;
  AuthErrorState({required this.failure});

  @override
  List get props => [failure];
}