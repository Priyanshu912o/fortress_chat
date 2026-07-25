import 'package:firebase_auth/firebase_auth.dart';
import 'package:fortress_chat/core/components/app_exceptions.dart';

AuthExceptions mapFromFirebaseAuthExceptionToAppExceptions(
  FirebaseAuthException exception,
) {
  switch (exception.code) {
    case 'invalid-email':
      return InvalidEmailException();
    case 'user-disabled':
      return UserDisabledException();
    case 'email-already-in-use':
      return EmailAlreadyInUseException();
    case 'invalid-credential':
      return InvalidCredentialException();
    case 'operation-not-allowed':
      return OperationNotAllowedException();
    case 'network-request-failed':
      return NetworkRequestFailedException();
    case 'too-many-requests':
      return TooManyRequestsException();
    case 'password-do-not-match':
      return PasswordsDoNotMatchException();
    default:
      return UnknownException();
  }
}
