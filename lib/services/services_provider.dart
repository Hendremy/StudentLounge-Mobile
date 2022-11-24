import 'package:studentlounge_mobile/services/lessons_repository.dart';
import 'package:studentlounge_mobile/services/user_repository.dart';

abstract class ServicesProvider{
  UserRepository get userRepo;
  LessonsRepository get lessonsRepo;
}

class AppServicesProvider extends ServicesProvider{
  final String appApiUrl;

  AppServicesProvider(this.appApiUrl);

  @override
  UserRepository get userRepo => AppUserRepository(baseUrl: appApiUrl);
  @override
  LessonsRepository get lessonsRepo => AppLessonsRepository(baseUrl: appApiUrl);
}
