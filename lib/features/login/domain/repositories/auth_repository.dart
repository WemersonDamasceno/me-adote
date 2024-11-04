import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<(String?, Failure?)> login(String email, String password);
  Future<String?> register(String email, String password, String name);
}
