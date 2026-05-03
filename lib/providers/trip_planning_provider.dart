import 'package:flutter/material.dart';

import '../models/trip_plan.dart';
import '../services/trip_planning_service.dart';


class TripPlanningProvider with ChangeNotifier{
  final TripPlanningService _service;
  List<TripPlan> _plans = [];
  bool _isLoading = false;
  String? _error;

  List<TripPlan> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  TripPlanningProvider(this._service);

  Future<void> loadPlans() async {
    _plans = await _service.loadPlans();
    notifyListeners();
  }

  Future<void> generateAndSavePlan({
    required String destination,
    required int days,
    required String companion,
    required String style,
    required List<String> foodPrefs,
    required String budget
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final plan = await _service.generatePlan(
          destination: destination,
          days: days,
          companion: companion,
          style: style,
          foodPrefs: foodPrefs,
          budget: budget
      );
      await _service.savePlan(plan);
      await loadPlans();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePlan(String id) async {
    await _service.deletePlan(id);
    await loadPlans();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }



}