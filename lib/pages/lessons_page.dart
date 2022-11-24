import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson_list/lesson_list_state.dart';
import 'package:studentlounge_mobile/blocs/login/login_state.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class LessonsPage extends StatefulWidget {
  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonsBloc>(
      create: (context) => LessonsBloc(
          lessonRepository: context.read<AppStudentServices>().lessonsRepo),
      child: BlocBuilder<LessonsBloc, LessonListState>(builder: (
        BuildContext context,
        LessonListState state,
      ) {
        if (state is LessonListLoadingFailed) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: theme.error,
              ),
            );
          });
        }

        return Scaffold(
            appBar: AppBar(
                backgroundColor: theme.primary,
                title: const Center(
                    child: Text('Cours',
                        style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
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
                          backgroundColor: theme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 20),
                          elevation: 5),
                      onPressed: state is! LoginLoading
                          ? _onLessonButtonPressed
                          : null,
                      child: const Text(
                        'Mathématiques',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ]),
            ))));
      }),
    );
  }

  _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLessonButtonPressed() {
    //_lessonBloc.add(const LessonButtonPressed("Mathématique"));
  }
}
