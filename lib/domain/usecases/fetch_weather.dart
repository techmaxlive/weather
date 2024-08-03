import 'package:weather/data/models/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class FetchWeather {
  final WeatherRepository weatherRepository;

  FetchWeather(this.weatherRepository);

  Future<Weather> execute(double latitude, double longitude, bool isCel) async {
    return await weatherRepository.getWeather(latitude, longitude, isCel);
  }
}
