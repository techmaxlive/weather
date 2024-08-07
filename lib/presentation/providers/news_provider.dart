import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/data/models/news.dart';
import 'package:weather/domain/usecases/fetch_news.dart';

import 'settings_provoider.dart';

class NewsProvider with ChangeNotifier {
  final FetchNews fetchNews;
  bool _isLoading = false;
  List<News> _news = [];
  NewsProvider(this.fetchNews);

  List<News> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> loadNews(String country, String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      _news = await fetchNews.execute(country, category);
    } catch (error) {
      // Handle error appropriately
      print("Error fetching news: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<News> filterNewsByWeather(String weatherCondition) {
    print('filterNewsByWeather-' + weatherCondition);
    final settingsProvider = Get.put(SettingController());
    Set<String> selectedCategories = settingsProvider.selectedCategories;
    print('selectedCategories==' + selectedCategories.toString());
    if (selectedCategories.isNotEmpty) {
      return _news.where((news) {
        print(news.category);
        return selectedCategories.contains(news.category.trim());
      }).toList();
    } else {
      switch (weatherCondition) {
        case 'cold':
          return _news
              .where((news) =>
                  news.category.trim() == 'business' ||
                  news.category.trim() == 'technology' ||
                  news.category.trim() == 'science')
              .toList();
        case 'hot':
          return _news
              .where((news) =>
                  news.category.trim() == 'entertainment' ||
                  news.category.trim() == 'general' ||
                  news.category.trim() == 'sports')
              .toList();
        case 'cool':
          return _news
              .where((news) =>
                  news.category.trim() == 'general' ||
                  news.category.trim() == 'health')
              .toList();
        default:
          return _news;
      }
    }
  }
}
