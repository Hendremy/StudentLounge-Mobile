import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class TutoratRepository extends StudentApiService {
  TutoratRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  Future<dynamic> askTutorat(String lessonId);
}

class AppTutoratRepository extends TutoratRepository {
  late String controllerUrl;
  AppTutoratRepository(
      {required super.studentId, required super.token, required super.apiUrl}) {
    controllerUrl = '$apiUrl/Tutorat';
  }

  @override
  Future<dynamic> askTutorat(String lessonId) async {
    Uri uri = Uri.parse('$controllerUrl/$lessonId');
    http.Response response = await http.put(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
