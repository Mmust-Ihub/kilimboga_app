import 'package:kilimboga/utils/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  void toggleTheme() {
    if (_themeData == darkMode) {
      _themeData = lightMode;
      notifyListeners();
    } else {
      _themeData = darkMode;
      notifyListeners();
    }
  }
}
