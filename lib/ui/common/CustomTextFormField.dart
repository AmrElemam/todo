// ignore_for_file: camel_case_types, must_be_immutable, file_names

import 'package:flutter/material.dart';

typedef validatorFun = String? Function(String? text);

class CustomTextFormField extends StatelessWidget {
  String hint;
  TextInputType? keyboardType;
  bool secure;
  validatorFun? validator;
  TextEditingController? controller;

  CustomTextFormField(
      {super.key,
      required this.hint,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.secure = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: secure,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(label: Text(hint)),
    );
  }
}
