import 'dart:convert';

import 'package:flutter_application_1/models/articles.dart';
import 'package:flutter_application_1/models/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<Articles>> fetchNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=02edd48f8fd8496696558c57d2a6ec72';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.articles ?? [];
    }
    throw Exception('bad request');
  }
}
