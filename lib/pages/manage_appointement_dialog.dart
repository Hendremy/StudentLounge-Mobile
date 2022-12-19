import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_state.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

import '../blocs/manage_appointement/manage_appointement_bloc.dart';

// ignore: must_be_immutable
class ManageAppointementDialog extends StatefulWidget {
  final AppointementRepository appointementRepository;
  final int tutoratId;
  const ManageAppointementDialog(
      {super.key,
      required this.appointementRepository,
      required this.tutoratId});

  @override
  State<ManageAppointementDialog> createState() =>
      _ManageAskAppointementDialogState();
}

class _ManageAskAppointementDialogState
    extends State<ManageAppointementDialog> {
  late ManageAppointementBloc manageAppointementBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      manageAppointementBloc = ManageAppointementBloc(
          appointementRepo: widget.appointementRepository,
          tutoratId: widget.tutoratId);
      return manageAppointementBloc;
    }, child: BlocBuilder<ManageAppointementBloc, ManageAppointementState>(
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: const Text(
            "Nouveau rendez-vous",
            style: TextStyle(color: theme.white),
          ),
          backgroundColor: theme.primary,
          content: SizedBox(
            child: _renderContent(state),
            width: 300,
            height: 400,
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ));
  }

  _renderContent(ManageAppointementState state) {
    return "hello";
  }
}
