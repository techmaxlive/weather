import 'package:flutter/material.dart';
import 'package:weather/presentation/views/home_screen.dart';
// import 'package:weather/presentation/views/news_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String tempHome = '/tempHome';
  // static const String news = '/news';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case news:
      //   return MaterialPageRoute(builder: (_) => const NewsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
