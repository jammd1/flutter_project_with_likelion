import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/services/search_history_storage_service.dart';

class SearchHistoryProvider with ChangeNotifier{
  final SearchHistoryStorageService _service;
  List<String> _history = [];

  SearchHistoryProvider(this._service);

  List<String> get history => _history;

  Future<void> loadHistory() async {
    _history = await _service.loadHistory();
    notifyListeners();
  }

  Future<void> addHistory(String query) async {
    await _service.addHistory(query);
    await loadHistory();
  }

  Future<void> removeHistory(String query) async {
    await _service.removeHistory(query);
    await loadHistory();
  }
}