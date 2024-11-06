import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/snackbar/snackbar_mixin.dart';
import '../../../../core/utils/extensions/name_extension.dart';
import '../../../../core/utils/session/user_session.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../login/presentation/views/login_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SnackbarMixin {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController = Provider.of<HomeController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Column(
        children: [
          cabecalho(size),
        ],
      ),
    );
  }

  Widget cabecalho(Size size) {
    final sessionUser = Provider.of<UserSession>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://i.pravatar.cc/332'),
                ),
              ),
              height: size.width * 0.12,
              width: size.width * 0.12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Olá, ${sessionUser.user?.name.firstName}!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () async {
              final logoutIsSuccess = await _homeController.logout();
              final tokenIsDeleted = await _homeController.deleteToken();

              if (tokenIsDeleted == false || logoutIsSuccess == false) {
                showSnackbarWithError(
                  context: context,
                  message: 'Erro ao realizar o logout!',
                  backgroundColor: const Color(0xFFD65745),
                  buttonColor: Colors.red,
                  buttonLabel: 'Fechar',
                  fontColor: Colors.white,
                );

                return;
              }

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            child: const Icon(
              Icons.login_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
