import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/pages/lesson_list_page.dart';
import 'package:studentlounge_mobile/pages/lesson_page.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';

class LessonsTab extends StatefulWidget {
  const LessonsTab({super.key});

  @override
  State<LessonsTab> createState() => _LessonsTabState();
}

class _LessonsTabState extends State<LessonsTab> {
  late LessonListBloc lessonListBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonListBloc>(
        create: (context) => LessonListBloc(
            lessonRepository: context.read<AppStudentServices>().lessonsRepo),
        child: Navigator(onGenerateRoute: ((settings) {
          Widget page = const LessonListPage();
          if (settings.name == 'lesson') {
            Lesson lesson = settings.arguments as Lesson;
            page = LessonPage(
              lesson: lesson,
            );
          }
          return MaterialPageRoute(builder: (_) => page);
        })));
  }
}
