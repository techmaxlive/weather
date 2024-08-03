import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/config/storage_utils.dart';

import 'news_provider.dart';
import 'weather_provider.dart';

class SettingController extends GetxController {
  var isCelsius = true.obs;
  var selectedCategories = <String>{}.obs;

  Future loadSettings() async {
    var isC = await MySharedPreferences().getIsCelsius();
    isCelsius(isC);
    var cate = await MySharedPreferences().getCategories();
    // Set<String> valSet = {};
    for (var i in cate) {
      if (selectedCategories.contains(i)) {
        selectedCategories.remove(i);
      } else {
        selectedCategories.add(i);
      }
    }
    selectedCategories.refresh();
  }

  void toggleTemperatureUnit() async {
    isCelsius.value = !isCelsius.value;
    MySharedPreferences().setIsCelsius(isCelsius.value);
  }

  void toggleCategory(String category, BuildContext context) async {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    MySharedPreferences().setCategories(selectedCategories.toList());
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final weatherCondition = weatherProvider.getWeatherCondition();
    newsProvider.filterNewsByWeather(weatherCondition);
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather/config/storage_utils.dart';

// import 'news_provider.dart';
// import 'weather_provider.dart';

// class SettingsProvider with ChangeNotifier {
//   bool _isCelsius = true;
//   Set<String> _selectedCategories = {};

//   bool get isCelsius => _isCelsius;
//   Set<String> get selectedCategories => _selectedCategories;

//   SettingsProvider() {
//     loadSettings();
//   }

//   Future loadSettings() async {
//     bool isDarkMode = await MySharedPreferences().getDarkTheme();
//     _isCelsius = isDarkMode;
//     var cate = await MySharedPreferences().getCategories();
//     _selectedCategories = cate.toSet();
//     notifyListeners();
//   }

//   void toggleTemperatureUnit() async {
//     _isCelsius = !_isCelsius;
//     MySharedPreferences().setIsCelsius(_isCelsius);
//     notifyListeners();
//   }

//   void toggleCategory(String category, BuildContext context) async {
//     if (_selectedCategories.contains(category)) {
//       _selectedCategories.remove(category);
//     } else {
//       _selectedCategories.add(category);
//     }
//     MySharedPreferences().setCategories(_selectedCategories.toList());
//     final newsProvider = Provider.of<NewsProvider>(context, listen: false);
//     final weatherProvider =
//         Provider.of<WeatherProvider>(context, listen: false);
//     final weatherCondition = weatherProvider.getWeatherCondition();
//     newsProvider.filterNewsByWeather(weatherCondition);
//     notifyListeners();
//   }
// }
