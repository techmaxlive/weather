import 'package:get_it/get_it.dart';
import 'package:weather/data/services/news_service.dart';
import 'package:weather/data/services/weather_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<WeatherService>(() => WeatherService());
  locator.registerLazySingleton<NewsService>(() => NewsService());
}
