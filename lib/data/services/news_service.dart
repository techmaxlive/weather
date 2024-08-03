import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/domain/entities/news.dart';

class NewsService {
  final String apiKey = '2f9049ca21a24298bdc2d0917fdacbed';

  Future<List<NewsModel>> fetchNews(String country, String category) async {
    var urlN =
        'https://newsapi.org/v2/top-headlines/sources?country=$country&apiKey=$apiKey';
    print(urlN);
    final response = await http.get(
      Uri.parse(urlN),
    );
    final data = jsonDecode(response.body);
    return (data['sources'] as List)
        .map((article) => NewsModel.fromJson(article))
        .toList();
  }
}
