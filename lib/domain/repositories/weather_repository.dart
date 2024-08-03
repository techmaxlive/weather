import 'package:weather/data/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(
    double latitude,
    double longitude,
    bool isCel,
  );
}
