import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_event.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

class LessonsBloc extends Bloc<LessonEvent, LessonListState> {
  final LessonsRepository lessonRepository;

  LessonsBloc({
    required this.lessonRepository,
  }) : super(LessonListInitial()) {
    on<LessonSelected>((event, emit) async {
      emit(LessonListLoading());
      try {
        await _getLesson(event, emit);
      } catch (error) {
        emit(LessonListLoadingFailed(error: error.toString()));
      }
    });

    on<LessonListLoadRetry>((event, emit) => _getUserLessons());

    _getUserLessons();
  }

  Future<void> _getLesson(
      LessonEvent event, Emitter<LessonListState> emit) async {}

  Future<void> _getUserLessons() async {
    emit(LessonListLoading());
    List<Lesson>? lessonList = await lessonRepository.getUserLessons();
    if (lessonList != null) {
      emit(LessonListLoaded(lessonList: lessonList));
    } else {
      emit(LessonListLoadingFailed(
          error: "Erreur lors du chargement des cours"));
    }
  }
}
