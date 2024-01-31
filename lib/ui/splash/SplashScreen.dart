// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/AuthProvider.dart';
import 'package:todo/ui/home/HomeScreen.dart';
import 'package:todo/ui/login/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splashscreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      navigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.png"), fit: BoxFit.fill)),
      child: Image.asset("assets/images/splash.png"),
    );
  }

  void navigate() async {
    var authprovider = Provider.of<Authprovider>(context, listen: false);
    if (authprovider.isUserLoggedInBefore()) {
      await authprovider.retrieveUserFromDatabase();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }
}
