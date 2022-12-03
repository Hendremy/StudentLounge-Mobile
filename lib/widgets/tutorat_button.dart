import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import '../blocs/tutorat/tutorat_cubit.dart';
import '../blocs/tutorat/tutorat_state.dart';
import '../repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class TutoratButton extends StatefulWidget {
  final Lesson lesson;
  const TutoratButton({super.key, required this.lesson});

  @override
  State<StatefulWidget> createState() => _TutoratButtonState(lesson);
}

class _TutoratButtonState extends State<TutoratButton> {
  late TutoratCubit tutoratCubit;
  final Lesson lesson;

  _TutoratButtonState(this.lesson);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          tutoratCubit = TutoratCubit(
              tutoratRepository:
                  context.read<AppStudentServices>().tutoratRepo);
          return tutoratCubit;
        },
        child: BlocListener<TutoratCubit, TutoratState>(
          listener: (context, state) {
            if (state is AskTutoratSuccess) {
              _displaySuccessTutorat(context);
            } else if (state is AskTutoratFailed) {
              _displayFailedTutorat(context);
            }
          },
          child: _action(lesson.id),
        ));
  }

  _action(lessonID) {
    return IconButton(
        onPressed: () {
          tutoratCubit.askTutorat(lessonID);
        },
        icon: const Icon(Icons.school_rounded, size: 24));
  }

  _displaySuccessTutorat(BuildContext context) {
    const success = SnackBar(
        content: Text("La demande de tutorat a été envoyé"),
        backgroundColor: theme.success);
    ScaffoldMessenger.of(context).showSnackBar(success);
  }
}

_displayFailedTutorat(BuildContext context) {
  const fail = SnackBar(
      content: Text("La demande de tutorat a échoué"),
      backgroundColor: theme.error);
  ScaffoldMessenger.of(context).showSnackBar(fail);
}
