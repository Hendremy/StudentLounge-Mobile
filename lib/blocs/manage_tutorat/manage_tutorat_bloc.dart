import 'package:bloc/bloc.dart';
import '../../repositories/tutorat_repository.dart';
import 'manage_tutorat_events.dart';
import 'manage_tutorat_state.dart';

class ManageTutoratBloc extends Bloc<ManageTutoratEvent, ManageTutoratState> {
  final TutoratRepository tutoratRepo;
  final String lessonId;

  ManageTutoratBloc({required this.tutoratRepo, required this.lessonId})
      : super(ManageTutoratInitial()) {
    on<RetryLoadTutoratEvent>((_, __) {
      //_ & __ pour indiquer que les arguments ne seront pas utilisés
      _loadTutorat(lessonId);
    });

    _loadTutorat(lessonId);
  }

  _loadTutorat(String lessonId) async {
    emit(ManageTutoratLoading());
    dynamic tutorat = await tutoratRepo.getTutorats(lessonId: lessonId);
    if (tutorat != null) {
      emit(ManageTutoratLoaded(tutorats: tutorat));
    } else {
      emit(ManageTutoratLoadFailed());
    }
  }
}
