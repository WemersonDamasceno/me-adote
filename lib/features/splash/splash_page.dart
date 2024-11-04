import 'package:flutter/material.dart';

import '../../core/components/button/button_controller.dart';
import '../../core/components/button/button_widget.dart';
import '../../core/constants/colors_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ButtonController buttonController = ButtonController();

  @override
  void initState() {
    super.initState();

    buttonController.changeState(ButtonStateEnum.enabled);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
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
                      onPressed: () {
                        buttonController.buttonState.value =
                            ButtonStateEnum.loading;
                        //Simular que está buscando o token
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.popAndPushNamed(
                            context,
                            '/login_page',
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
