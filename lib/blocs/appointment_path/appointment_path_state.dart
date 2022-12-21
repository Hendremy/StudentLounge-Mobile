import 'package:studentlounge_mobile/models/map_path.dart';

abstract class AppointmentPathState {}

class AppointmentPathInitial extends AppointmentPathState {}

class AppointmentPathLoading extends AppointmentPathState {}

class AppointmentPathLoaded extends AppointmentPathState {
  final MapPath path;

  AppointmentPathLoaded({required this.path});
}

class AppointmentPathLoadFailed extends AppointmentPathState {}
