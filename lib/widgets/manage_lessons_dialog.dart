import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_events.dart';
import 'package:studentlounge_mobile/blocs/manage_lessons/manage_lessons_state.dart';
import 'package:studentlounge_mobile/repositories/lessons_repository.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

class ManageLessonsDialog extends StatefulWidget {
  const ManageLessonsDialog({super.key});

  @override
  State<ManageLessonsDialog> createState() => _ManageLessonsDialogState();
}

class _ManageLessonsDialogState extends State<ManageLessonsDialog> {
  late ManageLessonsBloc manageLessonBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      manageLessonBloc = ManageLessonsBloc(
          lessonsRepo: context.read<LessonsRepository>());
      return manageLessonBloc;
    }, child: BlocBuilder<ManageLessonsBloc, ManageLessonsState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text(
            "Gérer mes cours",
            style: TextStyle(color: theme.white),
          ),
          backgroundColor: theme.primary,
          content: _renderContent(state),
        );
      },
    ));
  }

  _renderContent(ManageLessonsState state) {
    if (state is ManageLessonsLoading) {
      return LoadingIndicator();
    } else if (state is ManageLessonsLoaded) {
      return Text("Youpi");
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement des cours", retry: _retry);
    }
  }

  _retry() {
    manageLessonBloc.add(RetryLoadLessonsEvent());
  }
}
