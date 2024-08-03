import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _prefs;
  static const isDarkMode = 'isDarkMode';
  static const isCelsius = 'isCelsius';
  static const selectedCategories = 'selectedCategories';
  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setDarkTheme(bool value) async {
    await initSharedPreferences();
    return _prefs!.setBool(isDarkMode, value);
  }

  Future<bool> getDarkTheme() async {
    await initSharedPreferences();
    return _prefs!.getBool(isDarkMode) ?? false;
  }

  setIsCelsius(bool value) async {
    await initSharedPreferences();
    return _prefs!.setBool(isCelsius, value);
  }

  Future<bool> getIsCelsius() async {
    await initSharedPreferences();
    return _prefs!.getBool(isCelsius) ?? false;
  }

  setCategories(List<String> value) async {
    await initSharedPreferences();
    return _prefs!.setStringList(selectedCategories, value);
  }

  Future<List<String>> getCategories() async {
    await initSharedPreferences();
    return _prefs!.getStringList(selectedCategories) ?? [];
  }

// clean prefs
  Future<bool> clearData() async {
    await initSharedPreferences();
    return _prefs!.clear();
  }
}
