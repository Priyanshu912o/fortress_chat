part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable{
  @override
  List get props=>[];
}

final class AuthUserChanged extends AuthenticationEvent{
  final UserEntity? user;
  AuthUserChanged({required this.user});
}

final class ResendVerifyEmail extends AuthenticationEvent{}

final class SignOutEvent extends AuthenticationEvent{}
final class SendResetPasswordEmailEvent extends AuthenticationEvent{
  final String email;
  SendResetPasswordEmailEvent({required this.email});

  @override
  List get props=>[email];
}
final class ResetPasswordEvent extends AuthenticationEvent{
  final String newPassword;
  final String oobCode;
  ResetPasswordEvent({required this.newPassword, required this.oobCode});

  @override
  List get props=>[newPassword,oobCode];
}

final class CheckEmailVerificationEvent extends AuthenticationEvent{}

final class AuthSigningInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthSigningInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email,password];
}

final class AuthSigningUpEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  AuthSigningUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
