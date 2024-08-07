import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/domain/entities/weather.dart';

class WeatherService {
  final String apiKey = 'e83b3c4c08285bf87b99f9bbc0abe3f0';

  Future<WeatherModel> fetchWeather(
    double latitude,
    double longitude,
    bool isCelsius,
  ) async {
    var urlW =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,hourly,alerts&units=${isCelsius ? 'metric' : 'imperial'}&appid=$apiKey";
    print(urlW);
    final response = await http.get(
      Uri.parse(
        urlW,
      ),
    );
    final data = jsonDecode(response.body);
    return WeatherModel.fromJson(data);
  }
}
