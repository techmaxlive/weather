import 'package:weather/data/models/news.dart';

class NewsModel extends News {
  NewsModel(
      {required super.name,
      required super.description,
      required super.url,
      required super.category});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      name: json['name'],
      description: json['description'].toString() == 'null'
          ? '-'
          : json['description'].toString(),
      url: json['url'],
      category: json['category'].toString() == 'null'
          ? '-'
          : json['category'].toString(),
    );
  }
}
