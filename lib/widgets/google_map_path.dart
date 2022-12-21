import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studentlounge_mobile/models/directions.dart';
import 'package:studentlounge_mobile/models/map_path.dart';

class GoogleMapPath extends StatefulWidget {
  final MapPath path;
  const GoogleMapPath({super.key, required this.path});

  @override
  State<GoogleMapPath> createState() => _GoogleMapPathState();
}

class _GoogleMapPathState extends State<GoogleMapPath> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController _googleMapController;
  late Marker _origin;
  late Marker _destination;
  late Directions _info;
  late Polyline _polyline;

  @override
  void initState() {
    _initialCameraPosition =
        CameraPosition(target: widget.path.current, zoom: 10);
    _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Ma position'),
        position: widget.path.current,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
    _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Point de rendez-vous'),
        position: widget.path.destination,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
    _info = widget.path.directions;
    _polyline = Polyline(
        polylineId: const PolylineId('path'),
        color: Colors.cyan,
        width: 5,
        points: _info.polylinePoints
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList());
    CameraUpdate.newLatLngBounds(_info.bounds, 100.0);
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {_origin, _destination},
      polylines: {_polyline},
    );
  }
}
