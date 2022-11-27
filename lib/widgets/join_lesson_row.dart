import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_events.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_state.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class JoinLessonRow extends StatefulWidget {
  final Lesson lesson;
  final LessonsRepository lessonsRepository;
  final JoinLessonState state;

  const JoinLessonRow(
      {super.key,
      required this.lesson,
      required this.lessonsRepository,
      required this.state});

  String get lessonName => lesson.name;

  @override
  State<JoinLessonRow> createState() => _JoinLessonRowState();
}

class _JoinLessonRowState extends State<JoinLessonRow> {
  late final JoinLessonBloc joinLessonBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        joinLessonBloc = JoinLessonBloc(
          lesson: widget.lesson,
          lessonsRepository: widget.lessonsRepository,
          joinLessonState: widget.state,
        );
        return joinLessonBloc;
      },
      child: BlocBuilder<JoinLessonBloc, JoinLessonState>(
        builder: (context, state) {
          return Card(
            child: ListTile(
              title: Text(widget.lessonName),
              trailing: SizedBox(
                child: _renderButton(state),
                width: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  _renderButton(JoinLessonState state) {
    if (state is LessonLeavable) {
      return IconButton(
          onPressed: () => joinLessonBloc.add(TryLeaveLesson()),
          color: theme.primary,
          icon: const Icon(Icons.remove));
    } else if (state is LessonJoinable) {
      return IconButton(
          onPressed: () => joinLessonBloc.add(TryJoinLesson()),
          color: theme.primary,
          icon: const Icon(Icons.add));
    } else {
      return LoadingIndicator();
    }
  }
}
