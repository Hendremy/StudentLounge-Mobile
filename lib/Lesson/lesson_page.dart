import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Login/login_state.dart';
import 'lesson_bloc.dart';
import 'lesson_event.dart';
import 'lesson_repository.dart';
import 'lesson_state.dart';

class LessonPage extends StatefulWidget {
  final LessonRepository lessonRepository;

  const LessonPage({Key? key, required this.lessonRepository})
      : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();

}

class _LessonPageState extends State<LessonPage>{
  late LessonBloc _lessonBloc;
  LessonRepository get _lessonRepository => widget.lessonRepository;

  @override
  void initState() {
    _lessonBloc = LessonBloc(lessonRepository: _lessonRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      bloc: _lessonBloc,
      builder: (
        BuildContext context,
        LessonState state,
      ){
      if (state is LessonFailure) {
        _onWidgetDidBuild(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(38, 18, 146, 100),
          title: const Center(
            child: Text(
                'Cours',
                style: TextStyle(fontSize: 30, fontFamily: 'Gugi')
            )
          )
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                        elevation: 5
                      ),
                      onPressed: state is! LoginLoading ? _onLessonButtonPressed : null,
                      child: const Text(
                        'Mathématiques',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                ]
              ),
            )
          )
        )
      );
      }
    );
  }

  _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
  _onLessonButtonPressed(){
    _lessonBloc.add(const LessonButtonPressed("Mathématique"));
  }
}