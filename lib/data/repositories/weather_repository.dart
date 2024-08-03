import 'package:weather/data/models/weather.dart';
import 'package:weather/data/services/weather_service.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService weatherService;

  WeatherRepositoryImpl(this.weatherService);

  @override
  Future<Weather> getWeather(
    double latitude,
    double longitude,
    bool isCe,
  ) async {
    return await weatherService.fetchWeather(latitude, longitude, isCe);
  }
}
