import 'package:weather/data/models/news.dart';
import 'package:weather/domain/repositories/news_repository.dart';

class FetchNews {
  final NewsRepository newsRepository;

  FetchNews(this.newsRepository);

  Future<List<News>> execute(String country, String category) async {
    return await newsRepository.getNews(country, category);
  }
}
