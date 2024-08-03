import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/constants.dart';
import 'data/repositories/news_repository.dart';
import 'data/repositories/weather_repository.dart';
import 'data/services/news_service.dart';
import 'data/services/weather_service.dart';
import 'domain/usecases/fetch_news.dart';
import 'domain/usecases/fetch_weather.dart';
import 'presentation/providers/news_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/weather_provider.dart';
import 'config/routes.dart';
import 'config/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            FetchWeather(WeatherRepositoryImpl(WeatherService())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(
            FetchNews(NewsRepositoryImpl(NewsService())),
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => SettingsProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: AppConstants.appName,
              theme: AppThemes.lightTheme(context),
              darkTheme: AppThemes.darkTheme(context),
              debugShowCheckedModeBanner: false,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: AppRoutes.home,
            );
          },
        ),
      ),
    );
  }
}
