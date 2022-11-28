import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/file_table.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;
  const LessonPage({super.key, required this.lesson});

  String get lessonName => lesson.name;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final List<LessonFile> fakeFiles = [
    LessonFile(
        id: "test",
        name: 'Fake.pdf',
        user: 'Test',
        date: DateTime.now(),
        type: FileType.summary),
    LessonFile(
        id: "test2",
        name: 'Fake.txt',
        user: 'Toto',
        date: DateTime.now(),
        type: FileType.notes),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.primary,
          title: Center(
              child: Text(widget.lessonName,
                  style: const TextStyle(fontSize: 30)))),
      body: SingleChildScrollView(child: FileTable(files: fakeFiles)),
    );
  }
}
