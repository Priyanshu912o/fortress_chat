part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable{
  @override
  List get props=>[];
}

final class ForgotPasswordEvent extends AuthenticationEvent{
  final String email;
  ForgotPasswordEvent({required this.email});

  @override
  List get props=>[email];
}

final class AuthUserChanged extends AuthenticationEvent{
  final UserEntity? user;
  AuthUserChanged({required this.user});
}

final class VerifyEmail extends AuthenticationEvent{}
final class SignOutEvent extends AuthenticationEvent{}
final class SendRecoveryEmailEvent extends AuthenticationEvent{}