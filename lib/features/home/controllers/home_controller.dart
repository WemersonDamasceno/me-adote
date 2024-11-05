import '../../login/domain/repositories/auth_repository.dart';

class HomeController {
  final AuthRepository _authRepository;

  HomeController(this._authRepository);

  Future<bool> logout() async {
    final result = await _authRepository.logout();

    return result.$1 ?? false;
  }

  Future<bool> deleteToken() async {
    final result = await _authRepository.deleteToken();

    return result.$1 ?? false;
  }

  void getPets() {}
}
