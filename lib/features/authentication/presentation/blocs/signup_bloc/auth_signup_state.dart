part of 'auth_signup_bloc.dart';

sealed class AuthSignUpState extends Equatable {
  const AuthSignUpState();

  @override
  List<Object> get props => [];
}

final class AuthSignUpInitialState extends AuthSignUpState {}

final class AuthSignUpLoadingState extends AuthSignUpState {}

final class AuthSignUpFailureState extends AuthSignUpState {
  final AuthFailures failure;

  const AuthSignUpFailureState({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class AuthSignUpSuccessState extends AuthSignUpState {
  final UserEntity? userEntity;

  const AuthSignUpSuccessState({required this.userEntity});
}
