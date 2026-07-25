import 'package:equatable/equatable.dart';
import 'package:fortress_chat/core/components/fields.dart';

sealed class AuthFailures extends Equatable {
  final String message;
  final List<Fields> fields;
  const AuthFailures({required this.message, required this.fields});

  @override
  List<Object?> get props => [message, fields];
}

class InvalidEmailFailure extends AuthFailures {
  const InvalidEmailFailure({required super.message, required super.fields});
}

class UserDisabledFailure extends AuthFailures {
  const UserDisabledFailure({required super.message, required super.fields});
}

class EmailAlreadyInUseFailure extends AuthFailures {
  const EmailAlreadyInUseFailure({
    required super.message,
    required super.fields,
  });
}

class InvalidCredentialFailure extends AuthFailures {
  const InvalidCredentialFailure({
    required super.message,
    required super.fields,
  });
}

class OperationNotAllowedFailure extends AuthFailures {
  const OperationNotAllowedFailure({
    required super.message,
    required super.fields,
  });
}

class NetworkRequestFailedFailure extends AuthFailures {
  const NetworkRequestFailedFailure({
    required super.message,
    required super.fields,
  });
}

class TooManyRequestsFailure extends AuthFailures {
  const TooManyRequestsFailure({required super.message, required super.fields});
}

class PasswordsDoNotMatchFailure extends AuthFailures {
  const PasswordsDoNotMatchFailure({
    required super.message,
    required super.fields,
  });
}

class UnknownFailure extends AuthFailures {
  const UnknownFailure({required super.message, required super.fields});
}
