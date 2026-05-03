import 'activity.dart';

class DayPlan{
  final int day;
  final List<Activity> activities;

  const DayPlan({
    required this.day,
    required this.activities
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json['day'],
      activities: (json['activities'] as List)
          .map((e) => Activity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'activities': activities.map((e) => e.toJson()).toList(),
    };
  }
}