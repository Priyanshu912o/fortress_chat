sealed class ChatExceptions implements Exception {
  final String message;
  const ChatExceptions(this.message);

  @override
  String toString() => message;
}

class ServerException extends ChatExceptions {
  const ServerException([super.message = 'A server error occurred.']);
}

class NetworkException extends ChatExceptions {
  const NetworkException([super.message = 'A network error occurred. Please check your connection.']);
}

class CacheException extends ChatExceptions {
  const CacheException([super.message = 'A local database cache error occurred.']);
}

class NotFoundException extends ChatExceptions {
  const NotFoundException([super.message = 'The requested resource was not found.']);
}

class ForbiddenException extends ChatExceptions {
  const ForbiddenException([super.message = 'You do not have permission to perform this action.']);
}

class UnauthorizedException extends ChatExceptions {
  const UnauthorizedException([super.message = 'Authentication required. Please sign in again.']);
}

class ValidationException extends ChatExceptions {
  const ValidationException([super.message = 'Validation failed.']);
}

class UnknownChatException extends ChatExceptions {
  const UnknownChatException([super.message = 'An unexpected error occurred.']);
}
