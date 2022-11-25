import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_events.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

class JoinLessonBloc extends Bloc<JoinLessonEvent, JoinLessonState> {
  final Lesson lesson;
  final LessonsRepository lessonsRepository;

  JoinLessonBloc({required this.lesson, required this.lessonsRepository}) : super(JoinLessonInitial(lesson: lesson)) {
    on<TryJoinLesson>((event, emit) {
      _joinLesson();
    });

    on<TryLeaveLesson>((event, emit) {
      _leaveLesson();
    });
  }

  _leaveLesson() async {
    emit(JoinLessonLoading(lesson: lesson));
    Lesson result = await lessonsRepository.leaveLesson(lesson.id);
    if(result.id == 0){
      emit(LessonJoined(lesson: lesson));
    }else{
      emit(LessonLeft(lesson: lesson));
    }
  }

  _joinLesson() async {
    emit(JoinLessonLoading(lesson: lesson));
    Lesson result = await lessonsRepository.joinLesson(lesson.id);
    if(result.id == 0){
      emit(LessonLeft(lesson: lesson));
    }else{
      emit(LessonJoined(lesson: lesson));
    }
  }
}