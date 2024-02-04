// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomSheetProvider extends ChangeNotifier {
  String title = "";
  String description = "";
  DateTime? selecteddate = DateTime.now();

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    description = value;
    notifyListeners();
  }

  void updateDate(DateTime value) {
    selecteddate = value;
    notifyListeners();
  }
}
