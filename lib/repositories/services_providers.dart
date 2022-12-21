import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';
import 'package:studentlounge_mobile/repositories/appointment_repository.dart';
import 'package:studentlounge_mobile/repositories/chats_repository.dart';
import 'package:studentlounge_mobile/repositories/lesson_files_repository.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/repositories/schedule_repository.dart';
import 'package:studentlounge_mobile/repositories/tutorat_repository.dart';
import 'package:studentlounge_mobile/repositories/user_repository.dart';

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
  AppointementRepository get appointementRepo;
  AppointmentRepository get appointmentRepository;
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
      controller: 'Lesson');

  @override
  LessonFilesRepository get lessonFilesRepo => AppLessonFilesRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'LessonFile',
      downloadPath: downloadPath);

  @override
  TutoringRepository get tutoratRepo => AppTutoringRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Tutoring');

  @override
  ChatRepository get chatRepo => AppChatRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Tutoring');

  @override
  ScheduleRepository get scheduleRepo => AppScheduleRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Agenda');

  @override
  AppointementRepository get appointementRepo => AppAppointementRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Appointments');

  @override
  AppointmentRepository get appointmentRepository => AppAppointmentRepository(
      studentId: user.id,
      token: user.token,
      apiUrl: apiUrl,
      controller: 'Appointments');
}
