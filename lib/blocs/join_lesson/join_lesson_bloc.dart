import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_events.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_state.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_event.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

class JoinLessonBloc extends Bloc<JoinLessonEvent, JoinLessonState> {
  final Lesson lesson;
  final LessonsRepository lessonsRepository;
  final LessonListBloc lessonListBloc;

  JoinLessonBloc(
      {required this.lesson,
      required this.lessonsRepository,
      required JoinLessonState joinLessonState,
      required this.lessonListBloc})
      : super(joinLessonState) {
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
    if (result.id == 0) {
      emit(LessonLeavable(lesson: lesson));
      lessonListBloc.add(LessonAdded(lesson: lesson));
    } else {
      emit(LessonJoinable(lesson: lesson));
      lessonListBloc.add(LessonRemoved(lesson: lesson));
    }
  }

  _joinLesson() async {
    emit(JoinLessonLoading(lesson: lesson));
    Lesson result = await lessonsRepository.joinLesson(lesson.id);
    if (result.id == 0) {
      emit(LessonJoinable(lesson: lesson));
      lessonListBloc.add(LessonRemoved(lesson: lesson));
    } else {
      emit(LessonLeavable(lesson: lesson));
      lessonListBloc.add(LessonAdded(lesson: lesson));
      //TODO: Lessonlistbloc est fermé, faudrait p-e recharger les lessons de l'user
      // au moment de la fermeture du pop-up
    }
  }
}
