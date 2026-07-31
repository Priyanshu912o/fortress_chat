import 'package:Fortress/core/components/app_exceptions.dart';
import 'package:Fortress/core/components/auth_failures.dart';
import 'package:Fortress/core/components/fields.dart';

AuthFailures mapFromFirebaseAuthExceptionToAuthFailure(
  AuthExceptions exception,
) {
  switch (exception) {
    case InvalidEmailException():
      return const InvalidEmailFailure(
        message: 'Email is not valid or badly formatted.',
        fields: [Fields.email],
      );
    case UserDisabledException():
      return const UserDisabledFailure(
        message: 'This user has been disabled. Please contact support.',
        fields: [Fields.snackbar],
      );
    case EmailAlreadyInUseException():
      return const EmailAlreadyInUseFailure(
        message: 'An account already exists for that email.',
        fields: [Fields.email],
      );
    case InvalidCredentialException():
      return const InvalidCredentialFailure(
        message: 'Invalid email or password.',
        fields: [Fields.snackbar],
      );
    case OperationNotAllowedException():
      return const OperationNotAllowedFailure(
        message: 'Operation is not allowed. Please contact support.',
        fields: [Fields.snackbar],
      );
    case NetworkRequestFailedException():
      return const NetworkRequestFailedFailure(
        message: 'Network error. Please check your internet connection.',
        fields: [Fields.snackbar],
      );
    case TooManyRequestsException():
      return const TooManyRequestsFailure(
        message: 'Too many atFortressts. Please try again later.',
        fields: [Fields.snackbar],
      );
    case PasswordsDoNotMatchException():
      return const PasswordsDoNotMatchFailure(
        message: 'Passwords don\'t match',
        fields: [Fields.password, Fields.confirmPassword],
      );
    default:
      return const UnknownFailure(
        message: 'An unknown authentication error occurred.',
        fields: [Fields.snackbar],
      );
  }
}
