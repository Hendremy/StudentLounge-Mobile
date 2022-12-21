import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_events.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_state.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/models/directions.dart';
import 'package:studentlounge_mobile/models/map_path.dart';
import 'package:studentlounge_mobile/repositories/directions_repository.dart';
import 'package:studentlounge_mobile/repositories/location_repository.dart';

class AppointmentPathBloc
    extends Bloc<AppointmentPathEvent, AppointmentPathState> {
  final LocationRepository locationRepository;
  final DirectionsRepository directionsRepository;
  final Appointment appointment;

  AppointmentPathBloc(
      {required this.locationRepository,
      required this.directionsRepository,
      required this.appointment})
      : super(AppointmentPathInitial()) {
    on<AppointmentPathRetryLoad>((event, emit) {
      _loadPath();
    });

    _loadPath();
  }

  _loadPath() async {
    emit(AppointmentPathLoading());
    try {
      LatLng current = await locationRepository.getDevicePosition();
      LatLng destination =
          await locationRepository.getAddressPosition(appointment.location);
      Directions directions = await directionsRepository.getDirections(
          origin: current, destination: destination);
      emit(AppointmentPathLoaded(
          path: MapPath(
              current: current,
              destination: destination,
              directions: directions)));
    } catch (ex) {
      emit(AppointmentPathLoadFailed());
    }
  }
}
