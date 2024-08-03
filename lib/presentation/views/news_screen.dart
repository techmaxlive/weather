import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:weather/config/constants.dart';
import 'package:weather/presentation/providers/news_provider.dart';
import 'package:weather/presentation/providers/settings_provoider.dart';
import 'package:weather/presentation/providers/weather_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  double convertTemperature(double temp, bool toCelsius) {
    if (toCelsius) {
      return (temp - 32) * 5 / 9; // Fahrenheit to Celsius
    } else {
      return temp * 9 / 5 + 32; // Celsius to Fahrenheit
    }
  }

  Widget rowTxt(IconData icon, int title, String value1, String value2,
      BuildContext context) {
    final settingsProvider = Get.put(SettingController());
    var date = DateTime.fromMillisecondsSinceEpoch(title * 1000);
    var day = DateFormat('EEEE').format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: AppColors.grey.withOpacity(.3),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 15,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Text(
            day,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          Obx(
            () => RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: convertTemperature(
                      double.parse(value1),
                      settingsProvider.isCelsius.value,
                    ).toStringAsFixed(0),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: settingsProvider.isCelsius.value ? '°C' : '°F',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  // WidgetSpan(
                  //   child: Transform.translate(
                  //     offset: const Offset(0.0, -15.0),
                  //     child: Text(
                  //       settingsProvider.isCelsius ? '°C' : '°F',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleSmall!
                  //           .copyWith(fontSize: 10),
                  //     ),
                  //   ),
                  // ),
                  TextSpan(
                    text: '   -   ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: double.parse(value2).toStringAsFixed(0),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: settingsProvider.isCelsius.value ? '°C' : '°F',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  // WidgetSpan(
                  //   child: Transform.translate(
                  //     offset: const Offset(0.0, -15.0),
                  //     child: Text(
                  //       settingsProvider.isCelsius ? '°C' : '°F',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleSmall!
                  //           .copyWith(fontSize: 10),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
          // Text(
          //   value,
          //   style: Theme.of(context).textTheme.headlineMedium,
          // )
        ],
      ),
    );
  }

  Future<void> launchURL(String url) async {
    // Check if the URL can be launched
    if (await canLaunchUrl(Uri.parse(url))) {
      // Launch the URL
      await launchUrlString(url);
    } else {
      // If the URL cannot be launched, throw an error
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // final newsProvider = Provider.of<NewsProvider>(context);
    // final weatherProvider = Provider.of<WeatherProvider>(context);
    // final weatherCondition = weatherProvider.getWeatherCondition();
    // final filteredNews = newsProvider.filterNewsByWeather(weatherCondition);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leadingWidth: 15,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 22,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Weather news",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Text(
                '5-day forecast',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Consumer<NewsProvider>(
                  builder: (context, newsProvider, child) {
                return Consumer<WeatherProvider>(
                  builder: (context, weatherProvider, child) {
                    final weatherCondition =
                        weatherProvider.getWeatherCondition();
                    final filteredNews =
                        newsProvider.filterNewsByWeather(weatherCondition);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: weatherProvider.weather == null
                              ? []
                              : weatherProvider.weather!.forecast.isEmpty
                                  ? []
                                  : weatherProvider.weather!.forecast.length > 5
                                      ? weatherProvider.weather!.forecast
                                          .sublist(
                                            weatherProvider
                                                    .weather!.forecast.length -
                                                5,
                                            weatherProvider
                                                .weather!.forecast.length,
                                          )
                                          .map(
                                            (e) => rowTxt(
                                              Icons.sunny,
                                              e.date,
                                              e.minTemperature,
                                              e.maxTemperature,
                                              context,
                                            ),
                                          )
                                          .toList()
                                      : weatherProvider.weather!.forecast
                                          .map(
                                            (e) => rowTxt(
                                              Icons.sunny,
                                              e.date,
                                              e.minTemperature,
                                              e.maxTemperature,
                                              context,
                                            ),
                                          )
                                          .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Text(
                            'Top Stories',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        newsProvider.isLoading
                            ? Center(
                                child: Container(
                                  height: 33,
                                  width: 33,
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x33000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 1),
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: const CircularProgressIndicator(
                                    color: AppColors.black,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : filteredNews.isNotEmpty
                                ? ListView.builder(
                                    itemCount: filteredNews.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final news = filteredNews[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ListTile(
                                          title: Text(
                                            news.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                news.description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              InkWell(
                                                onTap: () async =>
                                                    launchURL(news.url),
                                                child: Text(
                                                  news.url,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          color:
                                                              AppColors.blue),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(
                                      child: Text(
                                        'No news available for the current weather condition.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
