import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/services/destination_service.dart';
import '../models/trip_destination.dart';

class TripProvider with ChangeNotifier {
  final DestinationService _destinationService;
  List<TripDestination> _destinations = [];
  bool _isLoading = false;
  String? _error;

  TripProvider(this._destinationService);

  List<TripDestination> get destinations => _destinations;
  bool get isLoading => _isLoading;
  String? get error => _error;



  // Detail 화면을 위한 id 값으로 Destination 데이터 찾기
  TripDestination? getDestinationByID(String id) {
    try {
      return _destinations.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }
  Future<List<TripDestination>?> getDestinations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _destinations = await _destinationService.getDestinations();
      debugPrint('${_destinations.length}');
      notifyListeners();
      return _destinations;
    } catch (e) {
      _error = e.toString();
      debugPrint(_error);
      notifyListeners();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
