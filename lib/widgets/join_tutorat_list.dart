import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/blocs/join_tutorat/join_tutorat_state.dart';

import '../models/tutorat_model.dart';
import '../repositories/tutorat_repository.dart';
import 'join_tutorat_row.dart';

class JoinTutoratList extends StatefulWidget {
  final List<Tutorat> tutoratList;
  final TutoringRepository tutoratRepository;

  const JoinTutoratList({
    super.key,
    required this.tutoratList,
    required this.tutoratRepository,
  });

  @override
  State<JoinTutoratList> createState() => _JoinTutoratListState();
}

class _JoinTutoratListState extends State<JoinTutoratList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <JoinTutoratRow>[
          for (Tutorat tutorat in widget.tutoratList)
            JoinTutoratRow(
                tutorat: tutorat, tutoratRepository: widget.tutoratRepository)
        ]));
  }
}
