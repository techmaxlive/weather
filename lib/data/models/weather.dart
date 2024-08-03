class Weather {
  final String temperature;
  final String condition;
  final List<Forecast> forecast;
  final WeatherDetModel weatherDetModel;

  Weather({
    required this.temperature,
    required this.condition,
    required this.forecast,
    required this.weatherDetModel,
  });
}

class Forecast {
  final int date;
  final String temperature;
  final String condition;
  final String minTemperature;
  final String maxTemperature;

  Forecast({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt'],
      temperature: json['temp']['day'].toString(),
      condition: json['weather'][0]['main'].toString(),
      minTemperature: json['temp']['min'].toString(),
      maxTemperature: json['temp']['max'].toString(),
    );
  }
}

class WeatherDetModel {
  WeatherDetModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.daily,
  });

  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Daily> daily;

  factory WeatherDetModel.fromJson(Map<String, dynamic> json) =>
      WeatherDetModel(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  final int dt;
  final String sunrise;
  final String sunset;
  final String temp;
  final String feelsLike;
  final String pressure;
  final String humidity;
  final String dewPoint;
  final String uvi;
  final String clouds;
  final String visibility;
  final String windSpeed;
  final String windDeg;
  final List<WeatherD> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"].toString(),
        sunset: json["sunset"].toString(),
        temp: json["temp"].toString(),
        feelsLike: json["feels_like"].toString(),
        pressure: json["pressure"].toString(),
        humidity: json["humidity"].toString(),
        dewPoint: json["dew_point"].toString(),
        uvi: json["uvi"].toString(),
        clouds: json["clouds"].toString(),
        visibility: json["visibility"].toString(),
        windSpeed: json["wind_speed"].toString(),
        windDeg: json["wind_deg"].toString(),
        weather: List<WeatherD>.from((json["weather"] as List).map(
          (x) => WeatherD.fromJson(x),
        )),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class WeatherD {
  WeatherD({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory WeatherD.fromJson(Map<String, dynamic> json) => WeatherD(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
    required this.weather,
  });

  final int dt;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final Temp temp;
  final FeelsLike feelsLike;
  final String pressure;
  final String humidity;
  final String dewPoint;
  final String windSpeed;
  final String windDeg;
  final String windGust;
  final String clouds;
  final String pop;
  final String rain;
  final String uvi;
  final List<WeatherD> weather;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"].toString(),
        sunset: json["sunset"].toString(),
        moonrise: json["moonrise"].toString(),
        moonset: json["moonset"].toString(),
        moonPhase: json["moon_phase"].toString(),
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"].toString(),
        humidity: json["humidity"].toString(),
        dewPoint: json["dew_point"].toString(),
        windSpeed: json["wind_speed"].toString(),
        windDeg: json["wind_deg"].toString(),
        windGust: json["wind_gust"].toString(),
        clouds: json["clouds"].toString(),
        pop: json["pop"].toString(),
        rain: json["rain"].toString(),
        uvi: json["uvi"].toString(),
        weather: List<WeatherD>.from(
          (json["weather"] as List).map(
            (x) => WeatherD.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final String day;
  final String night;
  final String eve;
  final String morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toString(),
        night: json["night"].toString(),
        eve: json["eve"].toString(),
        morn: json["morn"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final String day;
  final String min;
  final String max;
  final String night;
  final String eve;
  final String morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toString(),
        min: json["min"].toString(),
        max: json["max"].toString(),
        night: json["night"].toString(),
        eve: json["eve"].toString(),
        morn: json["morn"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}
