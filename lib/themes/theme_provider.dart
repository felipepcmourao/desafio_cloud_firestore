import 'package:desafio_cloud_firestore/themes/dark_mode.dart';
import 'package:desafio_cloud_firestore/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData (ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme (){
    if (themeData == lightMode){
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}