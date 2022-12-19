// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppointmentRequest {
  final int tutoringId;
  final String start;
  final String end;
  final String location;

  AppointmentRequest({
    required this.tutoringId,
    required this.start,
    required this.end,
    required this.location,
  });
}
