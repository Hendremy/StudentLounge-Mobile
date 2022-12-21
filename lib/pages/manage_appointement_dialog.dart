import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_state.dart';
import 'package:studentlounge_mobile/repositories/adress_search.dart';
import 'package:studentlounge_mobile/repositories/place_service.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';
import '../blocs/manage_appointement/manage_appointement_bloc.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class ManageAppointementDialog extends StatefulWidget {
  final AppointementRepository appointementRepository;
  final int tutoratId;
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 10);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 10);
  DateTime startDate = DateTime.utc(2022, 10, 10);
  DateTime endDate = DateTime.utc(2022, 10, 10);
  ManageAppointementDialog(
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
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final starthours = widget.startTime.hour.toString().padLeft(2, '0');
    final startminutes = widget.startTime.minute.toString().padLeft(2, '0');
    final startday = widget.startDate.day.toString().padLeft(2, '0');
    final startmonth = widget.startDate.month.toString().padLeft(2, '0');
    final startyear = widget.startDate.year.toString().padLeft(2, '0');
    final endhours = widget.endTime.hour.toString().padLeft(2, '0');
    final endminutes = widget.endTime.minute.toString().padLeft(2, '0');
    final endday = widget.endDate.day.toString().padLeft(2, '0');
    final endmonth = widget.endDate.month.toString().padLeft(2, '0');
    final endyear = widget.endDate.year.toString().padLeft(2, '0');

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
            child: _renderContent(
                state,
                starthours,
                startminutes,
                startday,
                startmonth,
                startyear,
                endhours,
                endminutes,
                endday,
                endmonth,
                endyear),
            width: 300,
            height: 400,
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ));
  }

  _renderContent(state, starthours, startminutes, startday, startmonth,
      startyear, endhours, endminutes, endday, endmonth, endyear) {
    return Form(
        child: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: controller,
            onTap: () async {
              final sessionToken = const Uuid().v4();
              final Suggestion? result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              );
              // This will change the text displayed in the TextField
              if (result != null) {
                setState(() {
                  controller.text = result.description;
                });
              }
            },
            // with some styling
            decoration: InputDecoration(
              icon: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: const Icon(
                  Icons.home,
                  color: theme.white,
                ),
              ),
              hintText: "Entrez l'adresse",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Début :",
            style: TextStyle(fontSize: 20, color: theme.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: widget.startTime);
                      if (newTime == null) return;
                      setState(() => widget.startTime = newTime);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        Text(
                          "  $starthours:$startminutes",
                          style:
                              const TextStyle(fontSize: 20, color: theme.white),
                        ),
                      ],
                    )),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: widget.startDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (newDate == null) return;
                    setState(() => widget.startDate = newDate);
                  },
                  child: Row(children: [
                    const Icon(Icons.event),
                    Text(
                      "  $startday/$startmonth/$startyear",
                      style: const TextStyle(fontSize: 20, color: theme.white),
                    ),
                  ]),
                ),
              ]),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Fin :",
            style: TextStyle(fontSize: 20, color: theme.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: widget.endTime);
                      if (newTime == null) return;
                      setState(() => widget.endTime = newTime);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        Text(
                          "  $endhours:$endminutes",
                          style:
                              const TextStyle(fontSize: 20, color: theme.white),
                        ),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: widget.endDate,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      if (newDate == null) return;
                      setState(() => widget.endDate = newDate);
                    },
                    child: Row(children: [
                      const Icon(Icons.event),
                      Text(
                        "  $endday/$endmonth/$endyear",
                        style:
                            const TextStyle(fontSize: 20, color: theme.white),
                      ),
                    ]))
              ]),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (controller.text.isNotEmpty) {
                try {
                  String startDateTimeUTC = formatDateTimeUTC(startday,
                      startmonth, startyear, starthours, startminutes);
                  String endDateTimeUTC = formatDateTimeUTC(
                      endday, endmonth, endyear, endhours, endminutes);
                  widget.appointementRepository.askAppointement(
                      tutoratId: widget.tutoratId,
                      start: startDateTimeUTC,
                      end: endDateTimeUTC,
                      location: controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Rendez-vous planifié'),
                    backgroundColor: theme.success,
                  ));
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Erreur'),
                    backgroundColor: theme.error,
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: theme.white),
            child: const Text('Enregistrer',
                style: TextStyle(fontSize: 20, color: theme.primaryDark)),
          ),
        ],
      ),
    ));
  }

  formatDateTimeUTC(day, month, year, hours, minutes) {
    //2022-01-13T10:25:35Z
    return "$year-$month-${day}T$hours:$minutes:00Z";
  }
}
