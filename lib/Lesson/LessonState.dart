import 'package:equatable/equatable.dart';

abstract class LessonState extends Equatable{
  const LessonState();

  @override
  List<Object> get props => [];
}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonFailure extends LessonState {
  final String error;

  const LessonFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LessonFailure { error: $error }';
}