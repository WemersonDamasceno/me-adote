import 'package:flutter/material.dart';

import 'src/modules/home/nav_home_page.dart';
import 'src/modules/login/login_page.dart';
import 'src/modules/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.yellow,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFFB228),
          secondary: const Color(0xFF1D1D1D),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashPage(),
        "/login_page": (context) => const LoginPage(),
        "/home_page": (context) => const NavHomePage(),
      },
    );
  }
}
