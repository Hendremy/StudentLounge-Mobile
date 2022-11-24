abstract class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});
}

abstract class StudentApiService extends ApiService{
  final String studentId;
  final String token;
  StudentApiService({required this.studentId, required this.token, required super.apiUrl});
}