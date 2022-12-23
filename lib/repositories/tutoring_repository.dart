import 'dart:convert';

import 'package:studentlounge_mobile/models/tutoring_request.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

import '../models/tutorat_model.dart';

abstract class TutoringRepository extends StudentApiService {
  TutoringRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  Future<dynamic> askTutorat(String lessonId);

  Future<dynamic> acceptTutorat(int tutoratId);
  Future<dynamic> getTutorats({required lessonId});
  Future<TutoringRequest> getUserTutoringRequestStatus({required lessonId});
}

class AppTutoringRepository extends TutoringRepository {
  AppTutoringRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller});

  @override
  Future<dynamic> askTutorat(String lessonId) async {
    Uri uri = Uri.parse('$controllerUrl/lesson/$lessonId');
    http.Response response = await http.post(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future acceptTutorat(tutoratId) async {
    Uri uri = Uri.parse('$controllerUrl/$tutoratId');
    http.Response response = await http.put(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<TutoringRequest> getUserTutoringRequestStatus(
      {required lessonId}) async {
    Uri uri = Uri.parse('$controllerUrl/lesson/$lessonId');
    http.Response response = await http.get(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return TutoringRequest.fromJson(response.body);
    }
    return TutoringRequest.empty();
  }

  @override
  Future getTutorats({required lessonId}) async {
    Uri uri = Uri.parse('$controllerUrl/lesson/$lessonId/all');
    http.Response response = await http.get(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return convertJSONTutoratList(response.body);
    }
    return null;
  }

  List<Tutorat> convertJSONTutoratList(String jsonList) {
    List<dynamic> tutoratMapList = jsonDecode(jsonList);
    List<Tutorat> tutoratList = [];
    for (var tutoratMap in tutoratMapList) {
      tutoratList.add(Tutorat.fromMap(tutoratMap));
    }
    return tutoratList;
  }
}
