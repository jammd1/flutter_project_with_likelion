
import 'dart:convert';

import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:http/http.dart' as http;

class DestinationService {
  DestinationService._();
  static const String baseUrl = 'http://192.168.200.101:3000/destinations/';
  static final DestinationService instance = DestinationService._();

  Future<List<TripDestination>> getDestinations() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final destinations = data as List;
        return destinations.map((d) => TripDestination.fromJson(d)).toList();
      } else {
        throw Exception('error while networking: ${response.statusCode} ');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}