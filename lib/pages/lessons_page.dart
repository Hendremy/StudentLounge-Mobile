import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_event.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_state.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/center_message.dart';
import 'package:studentlounge_mobile/widgets/lesson_button_list.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/manage_lessons_dialog.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

class LessonsPage extends StatefulWidget {
  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late LessonsBloc lessonBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonsBloc>(
      create: (context) {
        lessonBloc = LessonsBloc(
            lessonRepository: context.read<AppStudentServices>().lessonsRepo);
        return lessonBloc;
      },
      child: BlocBuilder<LessonsBloc, LessonListState>(builder: (
        BuildContext context,
        LessonListState state,
      ) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: theme.primary,
                actions: [
                  IconButton(
                      onPressed: _displayJoinLessons,
                      icon: const Icon(Icons.add))
                ],
                title: const Center(
                    child: Text('Cours',
                        style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
            body: _renderBody(state));
      }),
    );
  }

  _renderBody(LessonListState state) {
    if (state is LessonListLoaded) {
      return LessonButtonList(
          lessonList: state.lessonList, onPressed: _onLessonButtonPressed);
    } else if (state is LessonListEmpty) {
      return const CenterMessage(text: "Vous n'êtes inscrit à aucun cours");
    } else if (state is LessonListLoading) {
      return LoadingIndicator();
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement de vos cours", retry: _retry);
    }
  }

  _onLessonButtonPressed(int id) {
    //_lessonBloc.add(const LessonButtonPressed("Mathématique"));
  }

  _retry() {
    lessonBloc.add(LessonListLoadRetry());
  }

  _displayJoinLessons() {
    showDialog(
        context: context, builder: (context) => const ManageLessonsDialog());
  }
}
