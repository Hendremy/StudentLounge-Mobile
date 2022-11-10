import 'package:bloc/bloc.dart';
import 'LessonEvent.dart';
import 'LessonRepository.dart';
import 'LessonState.dart';

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