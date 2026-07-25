part of 'auth_signin_bloc.dart';

sealed class AuthSignInEvent extends Equatable {
  const AuthSignInEvent();

  @override
  List<Object> get props => [];
}

class AuthSigningInEvent extends AuthSignInEvent {
  final String email;
  final String password;

  const AuthSigningInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email,password];
}
