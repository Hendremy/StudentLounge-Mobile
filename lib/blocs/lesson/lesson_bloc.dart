import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_events.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_state.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lesson_files_repository.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final Lesson lesson;
  final LessonFilesRepository lessonFilesRepository;

  LessonBloc({required this.lessonFilesRepository, required this.lesson})
      : super(LessonInitial()) {
    on<RetryFileLoad>((event, emit) {
      _loadLessonFiles();
    });
  }

  _loadLessonFiles() async {
    emit(LessonFilesLoading());
    List<LessonFile>? lessonFiles =
        await lessonFilesRepository.getLessonFiles(lesson.id);
    if (lessonFiles != null) {
      emit(LessonFilesLoaded(lessonFiles: lessonFiles));
    } else {
      emit(LessonFilesLoadFailed());
    }
  }
}
