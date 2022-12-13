import 'package:studentlounge_mobile/models/agenda_event.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class ScheduleRepository extends StudentApiService {
  ScheduleRepository({
    required super.studentId, 
    required super.token, 
    required super.apiUrl, 
    required super.controller});

  Future<List<AgendaEvent>> getUserAgendas();
}

class AppScheduleRepository extends ScheduleRepository{
  AppScheduleRepository({
    required super.studentId, 
    required super.token, 
    required super.apiUrl,
    required super.controller});
  
  @override
  Future<List<AgendaEvent>> getUserAgendas() async {
    Uri uri = Uri.parse(controllerUrl);
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      
    }
  }


}