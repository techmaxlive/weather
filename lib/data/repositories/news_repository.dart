import 'package:weather/data/models/news.dart';
import 'package:weather/data/services/news_service.dart';
import 'package:weather/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService newsService;

  NewsRepositoryImpl(this.newsService);

  @override
  Future<List<News>> getNews(String country, String category) async {
    return await newsService.fetchNews(country, category);
  }
}
