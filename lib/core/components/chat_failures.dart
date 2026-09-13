import 'package:equatable/equatable.dart';

sealed class ChatFailures extends Equatable {
  final String message;
  const ChatFailures({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends ChatFailures {
  const ServerFailure({required super.message});
}

class NetworkFailure extends ChatFailures {
  const NetworkFailure({required super.message});
}

class CacheFailure extends ChatFailures {
  const CacheFailure({required super.message});
}

class NotFoundFailure extends ChatFailures {
  const NotFoundFailure({required super.message});
}

class ForbiddenFailure extends ChatFailures {
  const ForbiddenFailure({required super.message});
}

class UnauthorizedFailure extends ChatFailures {
  const UnauthorizedFailure({required super.message});
}

class ValidationFailure extends ChatFailures {
  const ValidationFailure({required super.message});
}

class UnknownChatFailure extends ChatFailures {
  const UnknownChatFailure({required super.message});
}
