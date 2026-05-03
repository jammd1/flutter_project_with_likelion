

import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryStorageService {
  SearchHistoryStorageService._();

  static const String _key = 'search_history';
  static const int _maxHistory = 5;

  static final SearchHistoryStorageService instance  = SearchHistoryStorageService._();

  Future<List<String>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addHistory(String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    history.remove(query);
    history.insert(0, query);
    if (history.length > _maxHistory) history.removeLast();
    await prefs.setStringList(_key, history);
  }

  Future<void> removeHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    history.remove(query);
    await prefs.setStringList(_key, history);
  }
}