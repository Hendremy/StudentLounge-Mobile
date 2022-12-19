import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointement/appointement_cubit.dart';
import 'package:studentlounge_mobile/blocs/appointement/appointement_state.dart';
import 'package:studentlounge_mobile/pages/manage_appointement_dialog.dart';
import '../repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class AppointementButton extends StatefulWidget {
  final int chatId;
  const AppointementButton({super.key, required this.chatId});

  @override
  State<StatefulWidget> createState() => _AppointementButtonState(chatId);
}

class _AppointementButtonState extends State<AppointementButton> {
  late AppointementCubit appointementCubit;
  final int chatId;

  _AppointementButtonState(this.chatId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          appointementCubit = AppointementCubit(
              appointementRepository:
                  context.read<AppStudentServices>().appointementRepo);
          return appointementCubit;
        },
        child: BlocListener<AppointementCubit, AppointementState>(
          listener: (context, state) {
            if (state is AskAppointementSuccess) {
              _displaySuccessAskAppointement(context);
            } else if (state is AskAppointementFailed) {
              _displayFailedAskAppointement(context);
            }
          },
          child: _action(widget.chatId),
        ));
  }

  _action(int chatId) {
    return IconButton(
        onPressed: () {
          appointementCubit.askAppointement(chatId);
        },
        icon: const Icon(Icons.school_rounded, size: 24));
  }

  _displaySuccessAskAppointement(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ManageAppointementDialog(
            appointementRepository: appointementCubit.appointementRepository,
            tutoratId: chatId));
  }
}

_displayFailedAskAppointement(BuildContext context) {
  const fail = SnackBar(
      content: Text("Rendez-vous annulé"), backgroundColor: theme.error);
  ScaffoldMessenger.of(context).showSnackBar(fail);
}
