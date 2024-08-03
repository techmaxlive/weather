import 'package:weather/data/models/weather.dart';
import 'package:weather/domain/usecases/fetch_weather.dart';

class WeatherController {
  final FetchWeather fetchWeather;

  WeatherController(this.fetchWeather);

  Future<Weather> getWeather(
      double latitude, double longitude, bool isCel) async {
    return await fetchWeather.execute(latitude, longitude, isCel);
  }
}
