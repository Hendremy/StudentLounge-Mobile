import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';
import 'package:studentlounge_mobile/repositories/appointment_repository.dart';
import 'package:studentlounge_mobile/repositories/chats_repository.dart';
import 'package:studentlounge_mobile/repositories/directions_repository.dart';
import 'package:studentlounge_mobile/repositories/lesson_files_repository.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/repositories/location_repository.dart';
import 'package:studentlounge_mobile/repositories/schedule_repository.dart';
import 'package:studentlounge_mobile/repositories/tutorat_repository.dart';
import 'package:studentlounge_mobile/repositories/user_repository.dart';
import 'package:studentlounge_mobile/.env.dart' as env;

abstract class AnonymServicesProvider {
  UserRepository get userRepo;
}

class AppAnonymServices extends AnonymServicesProvider {
  final String apiUrl;

  AppAnonymServices({required this.apiUrl});

  @override
  UserRepository get userRepo =>
      AppUserRepository(apiUrl: apiUrl, controller: 'Auth');
}

abstract class StudentServicesProvider {
  LessonsRepository get lessonsRepo;
  LessonFilesRepository get lessonFilesRepo;
  TutoringRepository get tutoratRepo;
  ChatRepository get chatRepo;
  ScheduleRepository get scheduleRepo;
  AppointmentRepository get appointmentRepo;
  LocationRepository get locationRepository;
  DirectionsRepository get directionsRepository;
}

class AppStudentServices extends StudentServicesProvider {
  final String apiUrl;
  final String downloadPath;
  final AppUser user;

  AppStudentServices(
      {required this.apiUrl, required this.user, required this.downloadPath});

  @override
  LessonsRepository get lessonsRepo => AppLessonsRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Lessons');

  @override
  LessonFilesRepository get lessonFilesRepo => AppLessonFilesRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'LessonFiles',
      downloadPath: downloadPath);

  @override
  TutoringRepository get tutoratRepo => AppTutoringRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Tutorings');

  @override
  ChatRepository get chatRepo => AppChatRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Chats');

  @override
  ScheduleRepository get scheduleRepo => AppScheduleRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Agendas');

  @override
  AppointmentRepository get appointmentRepo => AppAppointmentRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Appointments');

  @override
  LocationRepository get locationRepository => LocationRepository();

  @override
  DirectionsRepository get directionsRepository => DirectionsRepository(
      apiUrl: 'https://maps.googleapis.com/maps/api',
      apiKey: env.googleMapsKey);
}
