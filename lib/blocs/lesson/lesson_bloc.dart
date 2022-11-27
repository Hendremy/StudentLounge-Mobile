import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_events.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<LessonEvent>((event, emit) {
      // TODO: implement event handler
    });

    _loadLessonFiles();
  }

  _loadLessonFiles() {
    emit(LessonFilesLoading());
  }
}
