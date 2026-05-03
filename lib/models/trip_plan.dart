import 'day_plan.dart';

class TripPlan {
  final String id;
  final String title;
  final String destination;
  final int days;
  final String companion;
  final String style;
  final List<String> foodPrefs;
  final String createdAt;
  final List<DayPlan> schedule;

  const TripPlan({
    required this.id,
    required this.title,
    required this.destination,
    required this.days,
    required this.companion,
    required this.style,
    required this.foodPrefs,
    required this.createdAt,
    required this.schedule
  });

  factory TripPlan.fromJson(Map<String, dynamic> json) {
    return TripPlan(
        id: json['id'],
        title: json['title'],
        destination: json['destination'],
        days: json['days'],
        companion: json['companion'],
        style: json['style'],
        foodPrefs: List<String>.from(json['foodPrefs']),
        createdAt: json['createdAt'],
        schedule: (json['schedule'] as List)
            .map((e) => DayPlan.fromJson(e))
            .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'destination': destination,
      'days': days,
      'companion': companion,
      'style': style,
      'foodPrefs': foodPrefs,
      'createdAt': createdAt,
      'schedule': schedule.map((e) => e.toJson()).toList(),
    };
  }
}





