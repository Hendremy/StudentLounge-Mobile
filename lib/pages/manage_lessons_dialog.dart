import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_events.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/join_lesson_list.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

// ignore: must_be_immutable
class ManageLessonsDialog extends StatefulWidget {
  final LessonsRepository lessonsRepository;
  List<Lesson> joinedLessons;
  ManageLessonsDialog(
      {super.key,
      required this.lessonsRepository,
      required this.joinedLessons});

  @override
  State<ManageLessonsDialog> createState() => _ManageLessonsDialogState();
}

class _ManageLessonsDialogState extends State<ManageLessonsDialog> {
  late ManageLessonsBloc manageLessonsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      manageLessonsBloc =
          ManageLessonsBloc(lessonsRepo: widget.lessonsRepository);
      return manageLessonsBloc;
    }, child: BlocBuilder<ManageLessonsBloc, ManageLessonsState>(
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: const Text(
            "Gérer mes cours",
            style: TextStyle(color: theme.white),
          ),
          backgroundColor: theme.primary,
          content: SizedBox(
            child: _renderContent(state),
            width: 300,
            height: 400,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 30, color: theme.white),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ));
  }

  _renderContent(ManageLessonsState state) {
    if (state is ManageLessonsLoading) {
      return LoadingIndicator();
    } else if (state is ManageLessonsLoaded) {
      return BlocProvider(
        create: (context) => manageLessonsBloc,
        child: JoinLessonList(
            lessonList: state.lessons,
            lessonsRepository: widget.lessonsRepository,
            joinedLessons: widget.joinedLessons),
      );
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement des cours", retry: _retry);
    }
  }

  _retry() {
    manageLessonsBloc.add(RetryLoadLessonsEvent());
  }
}
