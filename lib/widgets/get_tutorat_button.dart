import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/tutorat_list/tutorat_list_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import '../blocs/tutorat/tutorat_cubit.dart';
import '../blocs/tutorat/tutorat_state.dart';
import '../pages/manage_tutorat_dialog.dart';
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
            if (state is GetTutoratSuccess) {
              _displaySuccessTutorat(state);
            } else if (state is GetTutoratFailed) {
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
        icon: const Icon(Icons.groups, size: 24));
  }

  _displaySuccessTutorat(state) {
    showDialog(
        context: context,
        builder: (context) => ManageTutoratDialog(
            tutoratRepository: tutoratCubit.tutoratRepository,
            lessonId: lesson.id));
  }
}

_displayFailedTutorat(BuildContext context) {
  const fail = SnackBar(
      content: Text("Le chargement des tutorats à échoué"),
      backgroundColor: theme.error);
  ScaffoldMessenger.of(context).showSnackBar(fail);
}
