import '../../../../core/errors/failures.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<(String?, Failure?)> login(String email, String password);
  Future<(String?, Failure?)> register(
    String email,
    String password,
    String name,
  );

  Future<(bool, Failure?)> saveUser(UserModel user);
  Future<(UserModel?, Failure?)> getUser(String uid);

  Future<(bool, Failure?)> saveToken(String token);
}
