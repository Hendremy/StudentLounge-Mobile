// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studentlounge_mobile/models/directions.dart';

class MapPath {
  final LatLng current;
  final LatLng destination;
  final Directions directions;

  MapPath({
    required this.current,
    required this.destination,
    required this.directions,
  });
}
