import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';

class LocationRepository {
  Future<LatLng> getDevicePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission de localisation refusée');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permission de localisation refusée à jamais.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Future<LatLng> getAddressPosition(String address) async {
    List<Location> locations =
        await locationFromAddress(address, localeIdentifier: 'fr_FR');
    if (locations.isNotEmpty) {
      Location place = locations.first;
      return LatLng(place.latitude, place.longitude);
    } else {
      throw ApiException(
          status: 404, message: "Address didn't match any location");
    }
  }
}
