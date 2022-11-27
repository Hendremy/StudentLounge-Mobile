import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_event.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/pages/manage_lessons_dialog.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/center_message.dart';
import 'package:studentlounge_mobile/widgets/lesson_button_list.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

class LessonListPage extends StatefulWidget {
  const LessonListPage({super.key});

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  late final LessonListBloc lessonListBloc;

  @override
  void initState() {
    lessonListBloc = BlocProvider.of<LessonListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonListBloc, LessonListState>(builder: (
      BuildContext context,
      LessonListState state,
    ) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: theme.primary,
              actions: [
                if (state is! LessonListLoadingFailed)
                  IconButton(
                    onPressed: () => _displayJoinLessons(state),
                    icon: const Icon(Icons.add),
                  )
              ],
              title: const Center(
                  child: Text('Cours',
                      style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
          body: _renderBody(state));
    });
  }

  _renderBody(LessonListState state) {
    if (state is LessonListLoaded) {
      if (state.lessonList.isEmpty) {
        return const CenterMessage(text: "Vous n'êtes inscrit à aucun cours");
      } else {
        return LessonButtonList(
            lessonList: state.lessonList, onPressed: _onLessonButtonPressed);
      }
    } else if (state is LessonListLoading) {
      return LoadingIndicator();
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement de vos cours", retry: _retry);
    }
  }

  _displayJoinLessons(state) {
    if (state is LessonListLoaded) {
      showDialog(
              context: context,
              builder: (context) => ManageLessonsDialog(
                  lessonsRepository: lessonListBloc.lessonRepository,
                  joinedLessons: state.lessonList))
          .then((_) => {lessonListBloc.add(LessonListLoadRetry())});
    }
  }

  _onLessonButtonPressed(Lesson lesson) {
    Navigator.pushNamed(context, 'lesson', arguments: lesson);
  }

  _retry() {
    lessonListBloc.add(LessonListLoadRetry());
  }
}
