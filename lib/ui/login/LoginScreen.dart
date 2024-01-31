// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogsUtils.dart';
import 'package:todo/FireBaseErrors.dart';
import 'package:todo/ValidationUtils.dart';
import 'package:todo/providers/AuthProvider.dart';
import 'package:todo/ui/home/HomeScreen.dart';
import 'package:todo/ui/register/RegisterScreen.dart';

import '../common/CustomTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFDFECDB),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/background.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hint: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Email";
                    }
                    if (!isValidEmail(text)) {
                      return "Email Bad Format";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  hint: "Password",
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  secure: true,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Password";
                    }
                    if (text.length < 6) {
                      return "Please Enter 6 Characters At Least";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF5D9CEC))),
                          onPressed: () {
                            login();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: const Text("Don't Have An Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authprovider = Provider.of<Authprovider>(context, listen: false);
    try {
      DialogUtils.showloading(context, "Loading...", iscancelable: false);
      authprovider.login(emailController.text, passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "Successfully Loading",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FireBaseErrors.userNotFound ||
          e.code == FireBaseErrors.wrongPassword ||
          e.code == FireBaseErrors.invalidCredintial) {
        DialogUtils.showMessage(context, "Wrong Email or Password",
            negActionTitle: "ok");
      }
    }
  }
}
