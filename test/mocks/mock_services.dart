import 'package:mockito/mockito.dart';
import 'package:weather/data/services/news_service.dart';
import 'package:weather/data/services/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

class MockNewsService extends Mock implements NewsService {}
