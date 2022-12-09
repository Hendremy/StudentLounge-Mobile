import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/join_lesson_list.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

import '../blocs/manage_tutorat/manage_tutorat_bloc.dart';
import '../blocs/manage_tutorat/manage_tutorat_events.dart';
import '../blocs/manage_tutorat/manage_tutorat_state.dart';
import '../models/tutorat_model.dart';
import '../repositories/tutorat_repository.dart';
import '../repositories/tutorat_repository.dart';
import '../widgets/join_tutorat_list.dart';

// ignore: must_be_immutable
class ManageTutoratDialog extends StatefulWidget {
  final TutoratRepository tutoratRepository;
  final String lessonId;
  const ManageTutoratDialog(
      {super.key, required this.tutoratRepository, required this.lessonId});

  @override
  State<ManageTutoratDialog> createState() => _ManageTutoratDialogState();
}

class _ManageTutoratDialogState extends State<ManageTutoratDialog> {
  late ManageTutoratBloc manageTutoratBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      manageTutoratBloc = ManageTutoratBloc(
          tutoratRepo: widget.tutoratRepository, lessonId: widget.lessonId);
      return manageTutoratBloc;
    }, child: BlocBuilder<ManageTutoratBloc, ManageTutoratState>(
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: const Text(
            "Tutorats demandés",
            style: TextStyle(color: theme.white),
          ),
          backgroundColor: theme.primary,
          content: SizedBox(
            child: _renderContent(state),
            width: 300,
            height: 400,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 30, color: theme.white),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ));
  }

  _renderContent(ManageTutoratState state) {
    if (state is ManageTutoratLoading) {
      return LoadingIndicator();
    } else if (state is ManageTutoratLoaded) {
      return BlocProvider(
        create: (context) => manageTutoratBloc,
        child: JoinTutoratList(
            tutoratList: state.tutorats,
            tutoratRepository: widget.tutoratRepository),
      );
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement des tutorats", retry: _retry);
    }
  }

  _retry() {
    manageTutoratBloc.add(RetryLoadTutoratEvent());
  }
}
