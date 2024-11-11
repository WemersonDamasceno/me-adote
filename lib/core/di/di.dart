import 'package:flutter_login/login/data/datasource/login_datasource.dart';
import 'package:flutter_login/login/data/repositories/auth_repository_impl.dart';
import 'package:flutter_login/login/domain/repositories/auth_repository.dart';
import 'package:flutter_login/login/presentation/controllers/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/home/controllers/home_controller.dart';
import '../../features/payment_method/data/datasource/payment_datasource.dart';
import '../../features/payment_method/data/repositories/payment_repository.dart';
import '../../features/payment_method/presentation/controllers/add_credit_controller.dart';
import '../../features/splash/data/datasources/splash_datasource.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/presentation/controllers/splash_controller.dart';
import '../utils/session/cart_session.dart';
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
    Provider<CartSession>(
      create: (_) => CartSession(),
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

    //***** Home ******** //
    Provider<HomeController>(
      create: (_) => HomeController(
        _.read<AuthRepository>(),
      ),
    ),

    //***** Payment ******** //
    Provider<PaymentDatasource>(
      create: (_) => PaymentDatasourceImpl(),
    ),

    Provider<PaymentRepository>(
      create: (_) => PaymentRepositoryImpl(
        _.read<PaymentDatasource>(),
      ),
    ),

    Provider<AddCreditController>(
      create: (_) => AddCreditController(
        _.read<PaymentRepository>(),
      ),
    ),
  ];
}
