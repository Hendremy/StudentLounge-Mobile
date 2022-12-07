import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import '../blocs/tutorat/tutorat_cubit.dart';
import '../blocs/tutorat/tutorat_state.dart';
import '../repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class GetTutoratButton extends StatefulWidget {
  final Lesson lesson;
  const GetTutoratButton({super.key, required this.lesson});

  @override
  State<StatefulWidget> createState() => _GetTutoratButtonState(lesson);
}

class _GetTutoratButtonState extends State<GetTutoratButton> {
  late TutoratCubit tutoratCubit;
  final Lesson lesson;

  _GetTutoratButtonState(this.lesson);

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
            if (state is AcceptTutoratSuccess) {
              _displaySuccessTutorat(context);
            } else if (state is AcceptTutoratFailed) {
              _displayFailedTutorat(context);
            }
          },
          child: _action(lesson.id),
        ));
  }

  _action(lessonID) {
    return IconButton(
        onPressed: () {
          tutoratCubit.getTutorats(lessonID);
        },
        icon: const Icon(Icons.how_to_reg_rounded, size: 24));
  }

  _displaySuccessTutorat(BuildContext context) {
    const success = SnackBar(
        content: Text("les tutorat seront affiché"),
        backgroundColor: theme.success);
    ScaffoldMessenger.of(context).showSnackBar(success);
  }
}

_displayFailedTutorat(BuildContext context) {
  const fail = SnackBar(
      content: Text("Le chargement des tutorats a échoué"),
      backgroundColor: theme.error);
  ScaffoldMessenger.of(context).showSnackBar(fail);
}
