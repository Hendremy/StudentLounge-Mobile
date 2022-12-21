import 'dart:convert';

import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

import '../models/tutorat_model.dart';

abstract class AppointementRepository extends StudentApiService {
  AppointementRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  Future<dynamic> askAppointement(
      {required int tutoratId,
      required String start,
      required String end,
      required String location});

  Future<dynamic> getAppointement({required tutoratId});
}

class AppAppointementRepository extends AppointementRepository {
  AppAppointementRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

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

  @override
  Future<dynamic> getAppointement({required tutoratId}) async {}

  List<Tutorat> convertJSONTutoratList(String jsonList) {
    List<dynamic> tutoratMapList = jsonDecode(jsonList);
    List<Tutorat> tutoratList = [];
    for (var tutoratMap in tutoratMapList) {
      tutoratList.add(Tutorat.fromMap(tutoratMap));
    }
    return tutoratList;
  }
}
