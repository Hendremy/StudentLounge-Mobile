import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/repositories/user_repository.dart';

abstract class AnonymServicesProvider {
  UserRepository get userRepo;
}

class AppAnonymServices extends AnonymServicesProvider {
  final String apiUrl;

  AppAnonymServices({required this.apiUrl});

  @override
  UserRepository get userRepo => AppUserRepository(apiUrl: apiUrl);
}

abstract class StudentServicesProvider {
  LessonsRepository get lessonsRepo;
}

class AppStudentServices extends StudentServicesProvider {
  final String apiUrl;
  final AppUser user;

  AppStudentServices({required this.apiUrl, required this.user});

  @override
  LessonsRepository get lessonsRepo => AppLessonsRepository(
      studentId: user.userId, token: user.token, apiUrl: apiUrl);
}
