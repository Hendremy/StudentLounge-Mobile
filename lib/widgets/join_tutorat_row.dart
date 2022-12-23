import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/repositories/tutoring_repository.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

import '../blocs/join_tutorat/join_tutorat_bloc.dart';
import '../blocs/join_tutorat/join_tutorat_events.dart';
import '../blocs/join_tutorat/join_tutorat_state.dart';
import '../models/tutorat_model.dart';

class JoinTutoratRow extends StatefulWidget {
  final Tutorat tutorat;
  final TutoringRepository tutoratRepository;

  const JoinTutoratRow({
    super.key,
    required this.tutorat,
    required this.tutoratRepository,
  });

  String get userName => tutorat.userName;
  int get tutoratId => tutorat.id;
  String? get userImage => tutorat.image;
  String? get tutorName => tutorat.tutorName;

  @override
  State<JoinTutoratRow> createState() => _JoinTutoratRowState();
}

class _JoinTutoratRowState extends State<JoinTutoratRow> {
  late final JoinTutoratBloc joinTutoratBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        joinTutoratBloc = JoinTutoratBloc(
          tutorat: widget.tutorat,
          tutoratRepository: widget.tutoratRepository,
        );
        return joinTutoratBloc;
      },
      child: BlocBuilder<JoinTutoratBloc, JoinTutoratState>(
        builder: (context, state) {
          return Card(
            child: ListTile(
              title: Text(widget.userName),
              trailing: SizedBox(
                child: _renderButton(state),
                width: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  _renderButton(state) {
    if (state is TutoratJoinable) {
      return IconButton(
          onPressed: () => joinTutoratBloc.add(TryJoinTutorat()),
          color: theme.primary,
          icon: const Icon(Icons.add_box_rounded));
    } else if (state is TutoratDisable) {
      return const IconButton(
          onPressed: null,
          color: theme.primary,
          icon: Icon(Icons.check_box_rounded));
    } else {
      return LoadingIndicator();
    }
  }
}
