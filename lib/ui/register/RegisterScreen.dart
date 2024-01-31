import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogsUtils.dart';
import 'package:todo/FireBaseErrors.dart';
import 'package:todo/ValidationUtils.dart';
import 'package:todo/providers/AuthProvider.dart';
import 'package:todo/ui/login/LoginScreen.dart';

import '../common/CustomTextFormField.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

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
                CustomTextFormField(
                  hint: "Full Name",
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Full Name";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  hint: "Username",
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Username";
                    }
                    return null;
                  },
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
                CustomTextFormField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  secure: true,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Password";
                    }
                    if (text != passwordController.text) {
                      return "Please Enter Match Password";
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
                        createAccount();
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text("Arleady Have An Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authprovider = Provider.of<Authprovider>(context, listen: false);
    try {
      DialogUtils.showloading(context, "Loading...", iscancelable: false);
      authprovider.register(emailController.text, passwordController.text,
          fullNameController.text, usernameController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "Successfully Create Account",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FireBaseErrors.weakPassword) {
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            negActionTitle: "ok");
      } else if (e.code == FireBaseErrors.emailArleadyInUse) {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.',
            negActionTitle: "ok");
      }
    } catch (e) {
      DialogUtils.showMessage(
          context, 'Something Went Wrong, Please Try Again.',
          negActionTitle: "ok");
    }
  }
}
