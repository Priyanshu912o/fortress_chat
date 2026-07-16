sealed class AuthExceptions implements Exception {}

class InvalidEmailException extends AuthExceptions {}

class UserDisabledException extends AuthExceptions {}

class EmailAlreadyInUseException extends AuthExceptions {}

class InvalidCredentialException extends AuthExceptions {}

class OperationNotAllowedException extends AuthExceptions {}

class NetworkRequestFailedException extends AuthExceptions {}

class TooManyRequestsException extends AuthExceptions {}

class PasswordsDoNotMatchException extends AuthExceptions {}

class UnknownException extends AuthExceptions {}
