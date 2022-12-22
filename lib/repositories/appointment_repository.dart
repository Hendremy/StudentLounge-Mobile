import 'dart:convert';
import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class AppointmentRepository extends StudentApiService {
  AppointmentRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  Future<List<Appointment>> getUserAppointments();
  Future<dynamic> askAppointement(
      {required int tutoratId,
      required String start,
      required String end,
      required String location});
}

class AppAppointmentRepository extends AppointmentRepository {
  AppAppointmentRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  @override
  Future<List<Appointment>> getUserAppointments() async {
    Uri uri = Uri.parse(controllerUrl);
    http.Response response = await http.get(uri, headers: tokenHeader);
    if (response.statusCode == 200) {
      return _reviveAppointments(response.body);
    } else {
      throw ApiException(status: response.statusCode, message: response.body);
    }
  }

  @override
  Future<dynamic> askAppointement(
      {required int tutoratId,
      required String start,
      required String end,
      required String location}) async {
    var body = jsonEncode({
      'tutoringId': tutoratId,
      'start': start,
      'end': end,
      'location': location
    });
    var url = Uri.parse(controllerUrl);
    http.Response response =
        await http.post(url, headers: jsonHeaders, body: body);
    if (response.statusCode == 200) {
      return true;
    }
    return null;
  }

  _reviveAppointment(jappointment) {
    Map<String, dynamic> appointment = jsonDecode(jappointment);
    return Appointment.fromMap(appointment);
  }

  _reviveAppointments(jappointments) {
    List<dynamic> appointments = jsonDecode(jappointments);
    return appointments.map((apt) => Appointment.fromMap(apt)).toList();
  }
}
