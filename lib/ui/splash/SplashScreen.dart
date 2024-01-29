import 'package:flutter/material.dart';
import 'package:todo/ui/home/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splashscreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2) , () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image:  DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.fill
        )
      ),
      child: Image.asset("assets/images/splash.png"),
    );
  }
}
