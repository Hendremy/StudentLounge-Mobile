import 'package:flutter/material.dart';

class TutoratButton extends StatelessWidget {
  final String text = "demande de tutorat";
  final Function tutorLesson;

  const TutoratButton({super.key, required this.tutorLesson});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: tutorLesson(),
        icon: const Icon(Icons.school_rounded, size: 24));
  }
}
