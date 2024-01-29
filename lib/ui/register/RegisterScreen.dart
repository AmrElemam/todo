import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "registerScreen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/background.png")
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
