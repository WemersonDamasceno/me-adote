import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDatasource remoteDatasource;

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
  Future<String?> register(String email, String password, String name) {
    return remoteDatasource.register(email, password, name);
  }
}
