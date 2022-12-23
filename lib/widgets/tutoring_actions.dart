import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/tutorat/tutorat_cubit.dart';
import 'package:studentlounge_mobile/blocs/tutoring_request/tutoring_request_cubit.dart';
import 'package:studentlounge_mobile/blocs/tutoring_request/tutoring_request_state.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/models/tutoring_request.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/widgets/get_tutorat_button.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/tutorat_accepted_button.dart';
import 'package:studentlounge_mobile/widgets/tutorat_button.dart';
import 'package:studentlounge_mobile/widgets/wait_tutorat_button.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class TutoringActions extends StatefulWidget {
  final Lesson lesson;
  const TutoringActions({super.key, required this.lesson});

  @override
  State<TutoringActions> createState() => _TutoringActionsState();
}

class _TutoringActionsState extends State<TutoringActions> {
  late TutoringRequestCubit reqCubit;

  @override
  void initState() {
    reqCubit = BlocProvider.of<TutoringRequestCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutoringRequestCubit, TutoringRequestState>(
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          backgroundColor: theme.primary,
          title: Text(widget.lesson.name, style: const TextStyle(fontSize: 30)),
          actions: _renderActions(widget.lesson, state),
        );
      },
    );
  }

  List<Widget> _renderActions(Lesson lesson, TutoringRequestState state) {
    if (state is TutoringRequestLoaded) {
      TutoringRequest req = state.request;
      List<Widget> actions = [];
      Widget? askTutorat = _askTutorat(req, lesson);
      Widget? getTutorat = _getTutorat(req, lesson);
      if (askTutorat != null) actions.add(askTutorat);
      if (getTutorat != null) actions.add(getTutorat);
      return actions;
    } else if (state is TutoringRequestLoading) {
      return [LoadingIndicator()];
    } else if (state is TutoringRequestInitial) {
      reqCubit.loadTutoringRequest(lessonId: lesson.id);
      return [];
    } else {
      return [
        IconButton(
            onPressed: () => reqCubit.loadTutoringRequest(lessonId: lesson.id),
            icon: const Icon(Icons.sync_problem))
      ];
    }
  }

  _askTutorat(TutoringRequest req, Lesson lesson) {
    if (!req.isEmpty) {
      if (req.isPending) {
        return const WaitTutoratButton();
      } else {
        return const TutoratAcceptedButton();
      }
    } else {
      return BlocProvider(
        create: ((context) => TutoratCubit(
            tutoratRepository: context.read<AppStudentServices>().tutoratRepo)),
        child: AskTutoratButton(lesson: lesson),
      );
    }
  }

  _getTutorat(TutoringRequest req, Lesson lesson) {
    if (!req.isEmpty) return;
    return BlocProvider(
        create: ((context) => TutoratCubit(
            tutoratRepository: context.read<AppStudentServices>().tutoratRepo)),
        child: GetTutoratButton(
          lesson: lesson,
        ));
  }
}
