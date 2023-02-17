import 'package:flutter/material.dart';

class Pages with ChangeNotifier {
  int pageIndex = 0;

  void changePage(index) {
    pageIndex = index;
    notifyListeners();
  }
}
