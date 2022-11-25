import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class ManageLessonsState {
  ManageLessonsState();

  Map<String, dynamic> get props => {};
}

class ManageLessonsInitial extends ManageLessonsState {}

class ManageLessonsLoading extends ManageLessonsState {}

class ManageLessonsLoaded extends ManageLessonsState {
  final List<Lesson> lessons;

  ManageLessonsLoaded({required this.lessons});

  @override
  Map<String, dynamic> get props => {"lessons": lessons};
}

class ManageLessonsLoadFailed extends ManageLessonsState {}
