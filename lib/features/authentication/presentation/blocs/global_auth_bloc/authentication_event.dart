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

final class VerifyEmail extends AuthenticationEvent{}
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