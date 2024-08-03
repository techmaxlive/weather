import 'package:weather/data/models/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNews(String country, String category);
}
