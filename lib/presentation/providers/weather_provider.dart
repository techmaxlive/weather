import 'package:flutter/material.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/domain/usecases/fetch_weather.dart';

class WeatherProvider with ChangeNotifier {
  final FetchWeather fetchWeather;
  Weather? _weather;
  bool _isLoading = false;
  WeatherProvider(this.fetchWeather);
  bool get isLoading => _isLoading;
  Weather? get weather => _weather;

  Future<void> loadWeather(
      double latitude, double longitude, bool isCel) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    try {
      _weather = await fetchWeather.execute(
        latitude,
        longitude,
        isCel,
      );
    } catch (error) {
      // Handle error appropriately
      print("Error fetching weather: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getWeatherCondition() {
    if (_weather == null) return 'unknown';
    if (double.parse(_weather!.temperature) <= 10) return 'cold';
    if (double.parse(_weather!.temperature) >= 25) return 'hot';
    return 'cool';
  }
}
