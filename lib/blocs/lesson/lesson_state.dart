abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonFilesLoading extends LessonState {}

class LessonFilesLoaded extends LessonState {}

class LessonFilesLoadFailed extends LessonState {}
