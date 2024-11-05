import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/login_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<(String?, Failure?)> login(String email, String password) async {
    try {
      final result = await remoteDatasource.login(email, password);

      return Future.value((result, null));
    } on UserNotFoundException {
      return Future.value((null, const UserNotFoundFailure()));
    } on WrongPasswordException {
      return Future.value((null, const WrongPasswordFailure()));
    } catch (e) {
      return Future.value((null, const ServerFailure()));
    }
  }

  @override
  Future<(String?, Failure?)> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final result = await remoteDatasource.register(email, password, name);

      return Future.value((result, null));
    } on EmailAlreadyInUseException {
      return Future.value((null, const EmailAlreadyInUseFailure()));
    } on PasswordIsTooWeakException {
      return Future.value((null, const PasswordIsTooWeakFailure()));
    } catch (e) {
      return Future.value((null, const ServerFailure()));
    }
  }

  @override
  Future<(bool, Failure?)> saveUser(UserModel user) async {
    try {
      final result = await remoteDatasource.saveUser(user);

      return Future.value((result, null));
    } on ServerException {
      return Future.value((false, const ServerFailure()));
    }
  }

  @override
  Future<(UserModel?, Failure?)> getUser(String uid) async {
    try {
      final result = await remoteDatasource.getUser(uid);

      return Future.value((result, null));
    } on ServerException {
      return Future.value((null, const ServerFailure()));
    }
  }

  @override
  Future<(bool, Failure?)> saveToken(String token) async {
    try {
      final result = await remoteDatasource.saveToken(token);
      return Future.value((result, null));
    } on ServerException {
      return Future.value((false, const ServerFailure()));
    }
  }
}
