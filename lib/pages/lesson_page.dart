import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_cubit.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_bloc.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_events.dart';
import 'package:studentlounge_mobile/blocs/lesson/lesson_state.dart';
import 'package:studentlounge_mobile/blocs/tutoring_request/tutoring_request_cubit.dart';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/file_table.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';
import 'package:studentlounge_mobile/widgets/tutorat_accepted_button.dart';
import 'package:studentlounge_mobile/widgets/tutorat_button.dart';
import 'package:studentlounge_mobile/widgets/tutoring_actions.dart';
import 'package:studentlounge_mobile/widgets/wait_tutorat_button.dart';
import '../blocs/tutorat/tutorat_cubit.dart';
import '../widgets/get_tutorat_button.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;
  const LessonPage({super.key, required this.lesson});

  String get lessonName => lesson.name;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late LessonBloc lessonBloc;
  late TutoratCubit tutoratCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            lessonBloc = LessonBloc(
                lesson: widget.lesson,
                lessonFilesRepository:
                    context.read<AppStudentServices>().lessonFilesRepo);
            return lessonBloc;
          }),
          BlocProvider(
            create: (context) => TutoringRequestCubit(
                tutoringRepository:
                    context.read<AppStudentServices>().tutoratRepo),
          ),
        ],
        child: BlocBuilder<LessonBloc, LessonState>(builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: TutoringActions(lesson: widget.lesson)),
            body: _renderBody(state),
          );
        }));
  }

  _renderBody(LessonState state) {
    if (state is LessonFilesLoaded) {
      return BlocProvider(
        create: (context) => DownloadFileCubit(
            lessonFilesRepository: lessonBloc.lessonFilesRepository),
        child: FileTable(files: state.lessonFiles),
      );
    } else if (state is LessonFilesLoadFailed) {
      return RetryMessage(
          text: "Erreur lors du chargement des fichiers", retry: _retryLoad);
    } else {
      return LoadingIndicator();
    }
  }

  _retryLoad() {
    lessonBloc.add(RetryFileLoad());
  }
}
