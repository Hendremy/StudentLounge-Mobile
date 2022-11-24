import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class LessonButton extends StatelessWidget {
  final Lesson lesson;
  final Function(int id) onPressed;

  const LessonButton(
      {super.key, required this.lesson, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: theme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
          elevation: 5),
      onPressed: onPressed(lesson.id),
      child: Text(
        lesson.name,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
