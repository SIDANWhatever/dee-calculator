import 'package:flutter/material.dart';

class ShowUnit with ChangeNotifier {
  int showUnit = 0;

  void changeUnit(newUnit) {
    showUnit = newUnit;
    notifyListeners();
  }
}
