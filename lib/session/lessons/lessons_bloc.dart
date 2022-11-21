import 'package:bloc/bloc.dart';
import 'lessons_event.dart';
import 'lessons_repository.dart';
import 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonEvent, LessonState> {
  final LessonsRepository lessonRepository;

  LessonsBloc({
    required this.lessonRepository,
  }) : super(LessonInitial()) {
    on<LessonButtonPressed>((event, emit) async {
      emit(LessonLoading());
      try {
        await getLesson(event, emit);
      } catch (error) {
        emit(LessonFailure(error: error.toString()));
      }
    });
  }

  Future<void> getLesson(LessonEvent event, Emitter<LessonState> emit) async {}
}
