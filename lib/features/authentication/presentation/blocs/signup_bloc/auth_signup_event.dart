part of 'auth_signup_bloc.dart';

sealed class AuthSignUpEvent extends Equatable {
  const AuthSignUpEvent();

  @override
  List<Object> get props => [];
}

class AuthSigningUpEvent extends AuthSignUpEvent {
  final String name;
  final String email;
  final String password;

  const AuthSigningUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
