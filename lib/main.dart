import 'package:flutter/material.dart';
import 'package:todo/ui/splash/SplashScreen.dart';

import 'ui/home/HomeScreen.dart';
import 'ui/login/LoginScreen.dart';
import 'ui/register/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDFECDB),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape:
                StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
            backgroundColor: Color(0xFF5D9CEC)),
        bottomAppBarTheme: const BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
          height: 80,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5D9CEC),
            primary: const Color(0xFF5D9CEC)),
        useMaterial3: false,
      ),
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
