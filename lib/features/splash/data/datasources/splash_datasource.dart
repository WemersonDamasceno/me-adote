import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../login/data/datasource/login_datasource.dart';

abstract class SplashDatasource {
  Future<String?> getToken();
}

class SplashDatasourceImpl implements SplashDatasource {
  @override
  Future<String?> getToken() async {
    try {
      final _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs.getString(SharedPreferencesKeys.token.name);
    } catch (e) {
      throw const ServerException();
    }
  }
}
