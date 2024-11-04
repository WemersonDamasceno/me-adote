import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  const Failure();
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [];

  const NetworkFailure();
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];

  const ServerFailure();
}

class UserNotFoundFailure extends Failure {
  @override
  List<Object> get props => [];

  const UserNotFoundFailure();
}

class WrongPasswordFailure extends Failure {
  @override
  List<Object> get props => [];

  const WrongPasswordFailure();
}

class EmailAlreadyInUseFailure extends Failure {
  @override
  List<Object> get props => [];

  const EmailAlreadyInUseFailure();
}

class PasswordIsTooWeakFailure extends Failure {
  @override
  List<Object> get props => [];

  const PasswordIsTooWeakFailure();
}
