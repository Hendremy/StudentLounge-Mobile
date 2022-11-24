import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/widgets/lesson_button.dart';

class LessonButtonList extends StatefulWidget {
  List<Lesson> lessonList;
  final Function(int id) onPressed;
  LessonButtonList(
      {super.key, required this.lessonList, required this.onPressed});

  @override
  State<LessonButtonList> createState() => _LessonButtonListState();
}

class _LessonButtonListState extends State<LessonButtonList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <LessonButton>[
          for (Lesson lesson in widget.lessonList)
            LessonButton(lesson: lesson, onPressed: widget.onPressed)
        ]));
  }
}
