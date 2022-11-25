import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_events.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_state.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

class ManageLessonsBloc extends Bloc<ManageLessonsEvent, ManageLessonsState> {
  final LessonsRepository lessonsRepo;

  ManageLessonsBloc({required this.lessonsRepo})
      : super(ManageLessonsInitial()) {
    on<RetryLoadLessonsEvent>((_, __) {
      //_ & __ pour indiquer que les arguments ne seront pas utilisés
      _loadLessons();
    });

    _loadLessons();
  }

  _loadLessons() async {
    emit(ManageLessonsLoading());
    dynamic lessons = await lessonsRepo.getAllLessons();
    if (lessons != null) {
      emit(ManageLessonsLoaded(lessons: lessons));
    } else {
      emit(ManageLessonsLoadFailed());
    }
  }
}
