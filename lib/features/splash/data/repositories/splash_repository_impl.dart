import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_datasource.dart';

class SplashRepositoryImpl implements SplashRespository {
  final SplashDatasource localDatasource;

  SplashRepositoryImpl(this.localDatasource);

  @override
  Future<String?> getToken() async {
    try {
      final result = await localDatasource.getToken();
      return Future.value(result);
    } on ServerException {
      return Future.value(null);
    }
  }
}
