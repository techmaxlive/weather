import 'package:weather/data/models/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.temperature,
    required super.condition,
    required super.forecast,
    required super.weatherDetModel,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<Forecast> forecastList = json.containsKey('daily')
        ? (json['daily'] as List).map((i) => Forecast.fromJson(i)).toList()
        : [];

    return WeatherModel(
      temperature: json['current']['temp'].toString(),
      condition: json['condition'].toString(),
      forecast: forecastList,
      weatherDetModel: WeatherDetModel(
        lat: json['lat'],
        lon: json['lon'],
        timezone: json['timezone'].toString(),
        timezoneOffset: json['timezone_offset'],
        current: Current.fromJson(json['current']),
        daily: (json['daily'] as List).map((e) => Daily.fromJson(e)).toList(),
      ),
    );
  }
}
