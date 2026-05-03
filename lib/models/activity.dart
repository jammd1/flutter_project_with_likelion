class Activity {
  final String time;
  final String place;
  final String description;
  final String category;
  final double? lat;
  final double? lng;

  const Activity({
    required this.time,
    required this.place,
    required this.description,
    required this.category,
    required this.lat,
    required this.lng
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
        time: json['time'],
        place: json['place'],
        description: json['description'],
        category: json['category'],
        lat: json['lat'],
        lng: json['lng']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'place': place,
      'description': description,
      'category': category,
      'lat': lat,
      'lng': lng
    };
  }
}