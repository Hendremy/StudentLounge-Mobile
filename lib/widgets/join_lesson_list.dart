import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/widgets/join_lesson_row.dart';

class JoinLessonList extends StatefulWidget {
  List<Lesson> lessonList;
  List<Lesson> joinedLessons;
  LessonsRepository lessonsRepository;

  JoinLessonList({
    super.key,
    required this.lessonList,
    required this.lessonsRepository,
    required this.joinedLessons,
  });

  @override
  State<JoinLessonList> createState() => _JoinLessonListState();
}

class _JoinLessonListState extends State<JoinLessonList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <JoinLessonRow>[
          for (Lesson lesson in widget.lessonList)
            JoinLessonRow(
              lesson: lesson,
              lessonsRepository: widget.lessonsRepository,
              state: getJoinLessonState(
                  widget.joinedLessons.contains(lesson), lesson),
            )
        ]));
  }

  JoinLessonState getJoinLessonState(bool lessonJoined, Lesson lesson) {
    return lessonJoined
        ? LessonLeavable(lesson: lesson)
        : LessonJoinable(lesson: lesson);
  }
}
