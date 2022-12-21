import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:studentlounge_mobile/models/api_exception.dart';
import '../models/directions.dart';

class DirectionsRepository {
  final String apiUrl;
  final String apiKey;

  DirectionsRepository({required this.apiUrl, required this.apiKey});

  Future<Directions> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    final queryParams = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': apiKey
    };
    Uri uri = Uri.parse(
        "$apiUrl/directions/json?origin=${queryParams['origin']}&destination=${queryParams['destination']}&key=${queryParams['key']}");
    http.Response response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      return _reviveDirections(response.body);
    } else {
      throw ApiException(
          status: response.statusCode,
          message: 'Failed to retrieve directions');
    }
  }

  _reviveDirections(String jsonDirections) {
    Map<String, dynamic> directions = jsonDecode(jsonDirections);
    return Directions.fromMap(directions);
  }
}
