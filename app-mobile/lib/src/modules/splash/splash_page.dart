import 'package:flutter/material.dart';

import '../../components/button_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.07, bottom: 8),
            child: const Text(
              "Faça um novo amigo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            "Adote um pet hoje!",
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
            child: ButtonWidget(
                size: size,
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/login_page");
                },
                textoButton: "Vamos lá?"),
          ),
          Container(
            height: size.height * 0.585,
            width: size.width,
            decoration: const BoxDecoration(
                color: Color(0xFFFFB228),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3000),
                  topRight: Radius.circular(300),
                )),
            child: Image.asset(
              "assets/images/mulher_02.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
