import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/repositories/lesson_files_repository.dart';
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
  LessonFilesRepository get lessonFilesRepo;
}

class AppStudentServices extends StudentServicesProvider {
  final String apiUrl;
  final AppUser user;

  AppStudentServices({required this.apiUrl, required this.user});

  @override
  LessonsRepository get lessonsRepo 
  => AppLessonsRepository(studentId: user.id, token: user.token, apiUrl: apiUrl);
      
  @override
  LessonFilesRepository get lessonFilesRepo 
  => AppLessonFilesRepository(studentId: user.id, token: user.token, apiUrl: apiUrl);
}
