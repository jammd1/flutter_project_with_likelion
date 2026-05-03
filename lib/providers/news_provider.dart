
import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/news_article.dart';
import 'package:my_flutter_mini_project/services/news_service.dart';

class NewsProvider with ChangeNotifier{
  final NewsService _newsService;
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _error;
  String? _query;

  NewsProvider(this._newsService);


  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get query => _query;

  Future<void> fetchNewsArticles(String? q) async {
    _isLoading = true;
    _error = null;
    _query = q;
    notifyListeners();

    try {
      if (_query != null) {
        _articles = [];
        _articles = await _newsService.getNewsArticles(_query);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshNews() async {
    if (_query != null) await fetchNewsArticles(_query);
  }
}