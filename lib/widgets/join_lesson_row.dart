import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_bloc.dart';
import 'package:studentlounge_mobile/blocs/join_lesson/join_lesson_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';

class JoinLessonRow extends StatefulWidget {
  final Lesson lesson;
  final LessonsRepository lessonsRepository;
  const JoinLessonRow({super.key, required this.lesson, required this.lessonsRepository});

  String get lessonName => lesson.name;

  @override
  State<JoinLessonRow> createState() => _JoinLessonRowState();
}

class _JoinLessonRowState extends State<JoinLessonRow> {
  late final JoinLessonBloc lessonBloc;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        lessonBloc = JoinLessonBloc(lesson: widget.lesson, lessonsRepository: widget.lessonsRepository);
        return lessonBloc;
        },
      child: BlocBuilder<JoinLessonBloc, JoinLessonState>(
        builder: (context, state) {
          return Card(
            child: ListTile(
                title: Text(widget.lessonName),
                trailing: SizedBox(child: _renderButton(state), width: 100, height: 100,),
              ),
          );
        },
      ),
    );
  }

  _renderButton(JoinLessonState state){
    if(state is LessonLeavable){
      return IconButton(onPressed: () {}, icon: const Icon(Icons.remove));
    }else if(state is LessonJoinable){
      return IconButton(onPressed: () {}, icon: const Icon(Icons.add));
    }else {
      return LoadingIndicator();
    }
  }
}