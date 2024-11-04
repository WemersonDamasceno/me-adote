class ServerException implements Exception {
  const ServerException();
}

class NetworkException implements Exception {
  const NetworkException();
}

class WrongPasswordException implements Exception {
  const WrongPasswordException();
}

class UserNotFoundException implements Exception {
  const UserNotFoundException();
}

class PasswordIsTooWeakException implements Exception {
  const PasswordIsTooWeakException();
}

class EmailAlreadyInUseException implements Exception {
  const EmailAlreadyInUseException();
}
