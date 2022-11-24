import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/lessons/lessons_event.dart';
import 'package:studentlounge_mobile/blocs/lessons/lessons_state.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

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
