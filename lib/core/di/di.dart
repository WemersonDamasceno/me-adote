import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/login/data/datasource/login_datasource.dart';
import '../../features/login/data/repositories/auth_repository_impl.dart';
import '../../features/login/domain/repositories/auth_repository.dart';
import '../../features/login/presentation/controllers/login_controller.dart';
import '../../features/splash/data/datasources/splash_datasource.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/presentation/controllers/splash_controller.dart';
import '../utils/session/user_session.dart';

class DIHelper {
  //singleton
  static final DIHelper singleton = DIHelper._internal();

  factory DIHelper() {
    return singleton;
  }

  DIHelper._internal();

  List<SingleChildWidget> dataProviders = [
    //***** Core ******** */
    Provider<UserSession>(
      create: (_) => UserSession(),
    ),

    //***** Login ******** */
    Provider<LoginDatasource>(
      create: (_) => LoginDatasourceImpl(),
    ),

    Provider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(
        _.read<LoginDatasource>(),
      ),
    ),

    Provider<LoginController>(
      create: (_) => LoginController(
        _.read<AuthRepository>(),
      ),
    ),

    //***** Splash ******** */
    Provider<SplashDatasource>(
      create: (_) => SplashDatasourceImpl(),
    ),

    Provider<SplashRespository>(
      create: (_) => SplashRepositoryImpl(
        _.read<SplashDatasource>(),
      ),
    ),

    Provider<SplashController>(
      create: (_) => SplashController(
        _.read<SplashRespository>(),
        _.read<AuthRepository>(),
      ),
    ),
  ];
}
