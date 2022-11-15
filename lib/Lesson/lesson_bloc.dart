import 'package:bloc/bloc.dart';
import 'lesson_event.dart';
import 'lesson_repository.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository lessonRepository;

  LessonBloc({
    required this.lessonRepository,
  }) : super(LessonInitial())  {
    on<LessonButtonPressed>((event, emit) async {
      emit(LessonLoading());
      try {
        await getLesson(event, emit);
      } catch (error) {
        emit(LessonFailure(error: error.toString()));
      }
    });
  }

  Future<void> getLesson(LessonEvent event, Emitter<LessonState> emit) async {

  }
}