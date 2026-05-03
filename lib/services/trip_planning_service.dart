import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:my_flutter_mini_project/models/trip_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/day_plan.dart';

class TripPlanningService {
  TripPlanningService._();

  static const String _apiKey = 'AIzaSyBArzgMnqw0LOInV4d1NG8jCIVlZWE56P4';
  static const String _storageKey = 'my_trip_plans';

  static final TripPlanningService instance = TripPlanningService._();

  String buildPrompt({
    required String destination,
    required int days,
    required String companion,
    required String style,
    required List<String> foodPrefs,
    required String budget
  }) {
    return '''
    1. 역할 지정: 너는 개인 맞춤 여행 일정 전문 플래너다.
    2. 조건: 다음 조건을 고려해서 맞춤 여행 플랜을 짜라.
        조건 1:
          목적지: $destination,
          기간: $days박 ${days + 1}일
          동행: $companion,
          여행 스타일: $style,
          음식 취향: ${foodPrefs.join(', ')},
          예산: $budget (원화)
        조건 2:  
          - $companion와 어울리는 장소 위주로 추천
          - $style에 맞는 일정 밀도로 구성
          - 이동 동선을 고려해 효율적인 순서로 배치
          - 여행 스타일, 음식 취향, 예산($budget)을 고려해 효율적인 장소 선정
          - 하루 5~6개 활동 포함
    3. 답변 형식 강제 명령: 아래 JSON 형식으로만 답해라. 설명, 마크다운 코드 블록, 기타 텍스트는 절대 배제하라.
        조건 1: category는 명소, 음식, 호텔, 이동수단 중 하나만 사용하라.
        조건 2: 식당과 장소는 구글 맵 기준으로 정확한 식당명과 장소명을 제공하라.
        { 
        "title": "여행 제목",
        "schedule": [
              {
               "day": 1,
               "activities": [
               {
                "time": "10:00",
                "place": "장소명",
                "description": "한줄 설명",
                "category": "명소", 
                "lat": 37.5,
                "lng": 120.8
               }
             ]
           }
         ]
        }
    ''';
  }

  Future<TripPlan> generatePlan({
    required String destination,
    required int days,
    required String companion,
    required String style,
    required List<String> foodPrefs,
    required budget
  }) async {
    final model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: _apiKey,
    );

    final prompt = buildPrompt(
      destination: destination,
      days: days,
      companion: companion,
      style: style,
      foodPrefs: foodPrefs,
      budget: budget
    );

    final response = await model.generateContent([Content.text(prompt)]);
    final rawText = response.text ?? '';

    final start = rawText.indexOf('{');
    final end = rawText.lastIndexOf('}') + 1;
    final jsonStr = rawText.substring(start, end);

    final Map<String, dynamic> parsed = jsonDecode(jsonStr);

    return TripPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: parsed['title'] as String,
      destination: destination,
      days: days,
      companion: companion,
      style: style,
      foodPrefs: foodPrefs,
      createdAt: DateTime.now().toIso8601String().substring(0, 10),
      schedule: (parsed['schedule'] as List)
          .map((s) => DayPlan.fromJson(s))
          .toList(),
    );
  }

  Future<void> savePlan(TripPlan plan) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_storageKey) ?? [];
    saved.add(jsonEncode(plan.toJson()));
    await prefs.setStringList(_storageKey, saved);
  }

  Future<List<TripPlan>> loadPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_storageKey) ?? [];
    return saved
        .map((s) => TripPlan.fromJson(jsonDecode(s)))
        .toList()
        .reversed
        .toList();
  }

  Future<void> deletePlan(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_storageKey) ?? [];
    saved.removeWhere((s) {
      final map = jsonDecode(s) as Map<String, dynamic>;
      return map['id'] == id;
    });
    await prefs.setStringList(_storageKey, saved);
  }
}
