import 'package:flutter_login/login/data/models/user_model.dart';
import 'package:flutter_login/login/domain/repositories/auth_repository.dart';

import '../../domain/repositories/splash_repository.dart';

class SplashController {
  final SplashRespository _splashRespository;
  final AuthRepository _authRepository;

  SplashController(this._splashRespository, this._authRepository);

  Future<String?> getToken() async {
    return await _splashRespository.getToken();
  }

  Future<UserModel?> getUser(String uid) async {
    final result = await _authRepository.getUser(uid);
    return result.$1;
  }
}
