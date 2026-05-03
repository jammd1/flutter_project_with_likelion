import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_flutter_mini_project/models/news_article.dart';
import 'package:http/http.dart' as http;

class NewsService {
  NewsService._();
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = String.fromEnvironment('NEWS_API_KEY');

  static final NewsService instance = NewsService._();

  Future<List<NewsArticle>> getNewsArticles(String? q) async {
    try {
      debugPrint(q);
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?q=$q&page=1&pageSize=10&apiKey=$_apiKey',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;
        return articles
            .where((article) => article['title'] != null && article['url'] != null)
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception('error while networking: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('error: $e');
      throw Exception('error while networking');
    }
  }
}
