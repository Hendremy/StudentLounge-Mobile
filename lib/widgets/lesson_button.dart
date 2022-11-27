import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class LessonButton extends StatelessWidget {
  final Lesson lesson;
  final Function(Lesson lesson) onPressed;

  const LessonButton(
      {super.key, required this.lesson, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: theme.secondary,
        child: ListTile(
            onTap: () => onPressed(lesson),
            trailing: const Icon(
              Icons.chevron_right,
              size: 40,
              color: theme.white,
            ),
            title: Text(lesson.name,
                style: const TextStyle(color: theme.white, fontSize: 30))));
  }
}
