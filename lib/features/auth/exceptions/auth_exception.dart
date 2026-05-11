/// Base class for all auth-related exceptions
abstract class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException()
    : super('Invalid email or password. Please try again.');
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException()
    : super('An account with this email already exists.');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
    : super('Password is too weak. Use at least 8 characters.');
}

class NetworkException extends AuthException {
  const NetworkException()
    : super('No internet connection. Please check your network.');
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException()
    : super('Your session has expired. Please log in again.');
}

class ServerException extends AuthException {
  final int? statusCode;
  const ServerException({
    this.statusCode,
    String message = 'A server error occurred.',
  }) : super(message);
}

class UnknownAuthException extends AuthException {
  const UnknownAuthException() : super('An unexpected error occurred.');
}
