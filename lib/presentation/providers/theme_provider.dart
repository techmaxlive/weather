import 'package:flutter/material.dart';
import 'package:weather/config/storage_utils.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    bool isDarkMode = await MySharedPreferences().getDarkTheme();
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  void _saveTheme() async {
    MySharedPreferences().setDarkTheme(_isDarkMode);
  }
}
