import 'dart:convert';
import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class ScheduleRepository extends StudentApiService {
  ScheduleRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  Future<List<Agenda>> getUserAgendas();
}

class AppScheduleRepository extends ScheduleRepository {
  AppScheduleRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  @override
  Future<List<Agenda>> getUserAgendas() async {
    Uri uri = Uri.parse(controllerUrl);
    http.Response response = await http.get(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return _reviveAgendas(response.body);
    } else {
      throw ApiException(status: response.statusCode, message: response.body);
    }
  }

  List<Agenda> _reviveAgendas(String jsonAgendas) {
    List<dynamic> agendas = jsonDecode(jsonAgendas);
    return agendas.map((agenda) => Agenda.fromMap(agenda)).toList();
  }
}
