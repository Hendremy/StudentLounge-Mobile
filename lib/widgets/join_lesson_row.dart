import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';

class JoinLessonRow extends StatefulWidget {
  final Lesson lesson;
  final LessonsRepository lessonsRepository;
  const JoinLessonRow({super.key, required this.lesson, required this.lessonsRepository});

  @override
  State<JoinLessonRow> createState() => _JoinLessonRowState();
}

class _JoinLessonRowState extends State<JoinLessonRow> {
  late final JoinLessonBloc lessonBloc;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        lessonBloc = JoinLessonBloc(lesson: widget.lesson, lessonsRepository: widget.lessonsRepository);
        return lessonBloc;
        },
      child: Row(),
    );
  }
}
