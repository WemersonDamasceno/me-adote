import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'features/login/presentation/views/login_page.dart';
import 'features/navigation/nav_home_page.dart';
import 'features/splash/presentation/views/splash_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      providers: DIHelper.singleton.dataProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Pets',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.yellow,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFFB228),
          secondary: const Color(0xFF1D1D1D),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login_page': (context) => const LoginPage(),
        '/home_page': (context) => const NavHomePage(),
      },
    );
  }
}
