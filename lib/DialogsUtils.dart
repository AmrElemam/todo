// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DialogUtils {
  static void showloading(BuildContext context, String message,
      {List<Widget>? actions, bool iscancelable = true}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: Text(message)),
              ],
            ),
            actions: actions,
          );
        },
        barrierDismissible: iscancelable);
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage(BuildContext context, String message,
      {String? posActionTitle,
      VoidCallback? posAction,
      String? negActionTitle,
      VoidCallback? negAction,
      bool isCancelable = true}) {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(posActionTitle)));
    }
    if (negActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(negActionTitle)));
    }
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Row(
              children: [
                Expanded(child: Text(message)),
              ],
            ),
            actions: actions,
          );
        },
        barrierDismissible: isCancelable);
  }
}
