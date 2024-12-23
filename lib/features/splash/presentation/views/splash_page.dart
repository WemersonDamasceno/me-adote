import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/session/user_session.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ButtonController buttonController = ButtonController();
  late SplashController _splashController;

  @override
  void initState() {
    super.initState();

    buttonController.changeState(ButtonStateEnum.enabled);

    _splashController = Provider.of<SplashController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: kToolbarHeight + 20, bottom: 20),
            child: Text(
              'Faça um novo amigo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            'Adote um pet hoje!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 35,
              bottom: size.height * .111,
              left: 20,
              right: 20,
            ),
            child: ValueListenableBuilder(
                valueListenable: buttonController.buttonState,
                builder: (_, buttonState, __) {
                  return ButtonWidget(
                      textButton: 'Vamos lá?',
                      backgroundColor: AppColors.primary,
                      buttonState: buttonState,
                      onPressed: () async {
                        buttonController.changeState(ButtonStateEnum.loading);

                        String? token = await _splashController.getToken();

                        if (token != null) {
                          // ******* Get remote user and Save local ************
                          final userRemote =
                              await _splashController.getUser(token);
                          Provider.of<UserSession>(context, listen: false)
                              .setUser(userRemote);
                        }

                        Future.delayed(const Duration(seconds: 1))
                            .whenComplete(() {
                          Navigator.popAndPushNamed(
                            context,
                            token != null ? '/home_page' : '/login_page',
                          );
                        });
                      });
                }),
          ),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(500),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Image.asset(
                'assets/images/mulher_02.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
