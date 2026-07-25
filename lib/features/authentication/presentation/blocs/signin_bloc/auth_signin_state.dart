part of 'auth_signin_bloc.dart';

sealed class AuthSignInState extends Equatable {
  const AuthSignInState();

  @override
  List<Object> get props => [];
}

final class AuthSignInInitialState extends AuthSignInState {}

final class AuthSignInFailureState extends AuthSignInState {
  final AuthFailures failure;

  const AuthSignInFailureState({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class AuthSignInLoadingState extends AuthSignInState {}

final class AuthSignInSuccessState extends AuthSignInState {
  final UserEntity? userEntity;

  const AuthSignInSuccessState({required this.userEntity});
}
