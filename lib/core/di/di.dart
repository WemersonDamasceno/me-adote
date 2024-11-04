import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/login/data/datasource/login_datasource.dart';
import '../../features/login/data/repositories/auth_repository_impl.dart';
import '../../features/login/domain/repositories/auth_repository.dart';
import '../../features/login/presentation/controllers/login_controller.dart';

class DIHelper {
  //singleton
  static final DIHelper singleton = DIHelper._internal();

  factory DIHelper() {
    return singleton;
  }

  DIHelper._internal();

  List<SingleChildWidget> dataProviders = [
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
  ];
}
