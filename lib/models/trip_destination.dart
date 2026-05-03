class TripDestination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String discount;
  final String imagePath;

  const TripDestination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.discount,
    required this.imagePath,
  });

  factory TripDestination.fromJson(Map<String, dynamic> json) {
    return TripDestination(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      description: json['description'] ?? '',
      discount: json['discount'],
      imagePath: json['imageUrl'],
    );
  }
}
