import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/config/constants.dart';
import 'package:weather/config/storage_utils.dart';
import 'package:weather/data/services/location_service.dart';
import 'package:weather/presentation/providers/news_provider.dart';
import 'package:weather/presentation/providers/settings_provoider.dart';
import 'package:weather/presentation/providers/weather_provider.dart';
import 'package:weather/presentation/views/news_screen.dart';
import 'package:weather/presentation/views/settings_screen.dart';

import 'bottom_c_paint.dart';
import 'shape_wid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final settingsProvider = Get.put(SettingController());
  @override
  void initState() {
    super.initState();
    _fetchDataBasedOnLocation();
  }

  Future<void> _fetchDataBasedOnLocation() async {
    var isDarkMode = await MySharedPreferences().getDarkTheme();
    print('isDarkMode==' + isDarkMode.toString());
    var cate = await MySharedPreferences().getCategories();
    print(cate.toString());
    final locationData =
        await LocationService().getUserLocation(onPermissionGranted: () {
      _fetchWeatherAndNews();
    });

    if (locationData['activegps']) {
      _fetchWeatherAndNews(locationData);
    } else {
      _fetchDataBasedOnLocation();
    }
  }

  void _fetchWeatherAndNews([Map<String, dynamic>? locationData]) async {
    locationData ??= await LocationService().getUserLocation();

    if (locationData['activegps']) {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      weatherProvider.loadWeather(
        locationData['latitude'],
        locationData['longitude'],
        settingsProvider.isCelsius.value,
      );
      await settingsProvider.loadSettings();
      final weatherCondition = weatherProvider.getWeatherCondition();
      newsProvider.loadNews(locationData['country'], weatherCondition);
    } else {
      print(locationData['error']);
    }
  }

  Widget item(
    IconData icon,
    String title,
    String value,
    double screenWidth,
    double screenHeight,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: screenWidth * 0.08,
          color: AppColors.yellow,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.005,
            bottom: screenHeight * 0.01,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.grey.withOpacity(.6),
                  fontSize: 12,
                ),
          ),
        ),
        Obx(
          () => RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: convertTemperature(
                    double.parse(value),
                    settingsProvider.isCelsius.value,
                  ).toStringAsFixed(0),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -15.0),
                    child: Text(
                      settingsProvider.isCelsius.value ? '°C' : '°F',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  double convertTemperature(double temp, bool toCelsius) {
    if (toCelsius) {
      return (temp - 32) * 5 / 9; // Fahrenheit to Celsius
    } else {
      return temp * 9 / 5 + 32; // Celsius to Fahrenheit
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          final openweathermap = weatherProvider.weather;

          // return weatherProvider.isLoading || openweathermap == null
          //     ? Center(
          //         child: Container(
          //           height: 33,
          //           width: 33,
          //           padding: const EdgeInsets.all(6),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: AppColors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Color(0x33000000),
          //                 blurRadius: 4,
          //                 offset: Offset(0, 1),
          //                 spreadRadius: 1,
          //               )
          //             ],
          //           ),
          //           child: const CircularProgressIndicator(
          //             color: AppColors.black,
          //             strokeWidth: 2,
          //           ),
          //         ),
          //       )
          //     : Stack(
          //         fit: StackFit.expand,
          //         children: [
          //           Positioned(
          //             top: -40,
          //             child: Image.asset(
          //               ImagePath.homebg,
          //               width: screenWidth,
          //               height: screenHeight - screenHeight * 0.15,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           Positioned(
          //             bottom: 5,
          //             height: screenHeight * 0.23,
          //             width: screenWidth,
          //             child: CustomPaint(
          //               painter: BottomCPaint(
          //                 color: AppColors.white,
          //               ),
          //               child: Column(
          //                 children: [
          //                   Container(
          //                     width: 45,
          //                     height: 2,
          //                     margin: EdgeInsets.only(top: screenHeight * 0.04),
          //                     color: Theme.of(context).colorScheme.surface,
          //                   ),
          //                   Padding(
          //                     padding:
          //                         EdgeInsets.only(top: screenHeight * 0.01),
          //                     child: Text(
          //                       'Wheather Today',
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   ),
          //                   const Spacer(),
          //                   Padding(
          //                     padding: EdgeInsets.only(
          //                       left: screenWidth * 0.05,
          //                       right: screenWidth * 0.05,
          //                       top: screenHeight * 0.01,
          //                       bottom: screenHeight * 0.025,
          //                     ),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         item(
          //                           Icons.sunny,
          //                           "humidity",
          //                           openweathermap
          //                               .weatherDetModel.current.humidity
          //                               .toString(),
          //                           screenWidth,
          //                           screenHeight,
          //                         ),
          //                         item(
          //                           Icons.sunny_snowing,
          //                           "Feels",
          //                           openweathermap
          //                               .weatherDetModel.current.feelsLike,
          //                           screenWidth,
          //                           screenHeight,
          //                         ),
          //                         item(
          //                           Icons.cloudy_snowing,
          //                           "Wind",
          //                           openweathermap
          //                               .weatherDetModel.current.windSpeed,
          //                           screenWidth,
          //                           screenHeight,
          //                         ),
          //                         item(
          //                           Icons.air_rounded,
          //                           "Clouds",
          //                           openweathermap
          //                               .weatherDetModel.current.clouds,
          //                           screenWidth,
          //                           screenHeight,
          //                         ),
          //                         item(
          //                           Icons.thermostat_auto_rounded,
          //                           "Temp",
          //                           openweathermap.temperature,
          //                           screenWidth,
          //                           screenHeight,
          //                         )
          //                       ],
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             top: screenHeight * 0.055,
          //             height: screenHeight * 0.1,
          //             right: 10,
          //             width: screenWidth,
          //             child: Padding(
          //               padding: EdgeInsets.only(left: screenWidth * 0.05),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(
          //                     Icons.location_on,
          //                     size: screenWidth * 0.065,
          //                     color: AppColors.white,
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 5),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           'Wheather Today  ${openweathermap.weatherDetModel.current.weather.first.main}',
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .titleLarge!
          //                               .copyWith(
          //                                 fontSize: screenWidth * 0.04,
          //                                 color: AppColors.white,
          //                               ),
          //                         ),
          //                         Text(
          //                           openweathermap.weatherDetModel.current
          //                               .weather.first.description,
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .titleLarge!
          //                               .copyWith(
          //                                 fontSize: screenWidth * 0.03,
          //                                 color: AppColors.white,
          //                               ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   const Spacer(),
          //                   IconButton(
          //                     onPressed: () {
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => const SettingScreen(),
          //                         ),
          //                       );
          //                     },
          //                     icon: Icon(
          //                       Icons.settings,
          //                       size: screenWidth * 0.07,
          //                       color: AppColors.white,
          //                     ),
          //                   ),
          //                   IconButton(
          //                     onPressed: () {
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => const NewsScreen(),
          //                         ),
          //                       );
          //                     },
          //                     icon: Icon(
          //                       Icons.newspaper_rounded,
          //                       size: screenWidth * 0.07,
          //                       color: AppColors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             top: screenHeight * 0.12,
          //             left: 0,
          //             child: Obx(
          //               () => RichText(
          //                 textAlign: TextAlign.center,
          //                 text: TextSpan(
          //                   children: [
          //                     TextSpan(
          //                       text: convertTemperature(
          //                         double.parse(openweathermap.temperature),
          //                         settingsProvider.isCelsius.value,
          //                       ).toStringAsFixed(0),
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .titleLarge!
          //                           .copyWith(
          //                             fontSize: screenWidth * 0.4,
          //                             color: AppColors.white,
          //                           ),
          //                     ),
          //                     WidgetSpan(
          //                       child: Transform.translate(
          //                         offset: const Offset(-5, -120.0),
          //                         child: Text(
          //                           settingsProvider.isCelsius.value
          //                               ? '°C'
          //                               : '°F',
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .titleSmall!
          //                               .copyWith(
          //                                 fontSize: 30,
          //                                 color: AppColors.white,
          //                               ),
          //                         ),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             right: -35,
          //             top: screenHeight / 2.5,
          //             child: Transform(
          //               alignment: FractionalOffset.center,
          //               transform: Matrix4.identity()..rotateZ(-1.56),
          //               child: Text(
          //                 "It's ${openweathermap.weatherDetModel.current.weather.first.main}",
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .titleSmall!
          //                     .copyWith(fontSize: 30, color: AppColors.white),
          //               ),
          //             ),
          //           )
          //         ],
          //       );
          return SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: WavyEdgeContainer(
                      child: Container(
                        width: screenWidth,
                        height: 240,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(
                          'Wavy Edge Container',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
