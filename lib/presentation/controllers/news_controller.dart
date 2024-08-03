import 'package:weather/data/models/news.dart';
import 'package:weather/domain/usecases/fetch_news.dart';

class NewsController {
  final FetchNews fetchNews;

  NewsController(this.fetchNews);

  Future<List<News>> getNews(String country, String category) async {
    return await fetchNews.execute(country, category);
  }
}
