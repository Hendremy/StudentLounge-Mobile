import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/tutorat/tutorat_state.dart';

import '../../repositories/tutorat_repository.dart';

class TutoratCubit extends Cubit<TutoratState> {
  final TutoratRepository tutoratRepository;
  TutoratCubit({required this.tutoratRepository}) : super(TutoratInitial());

  void askTutorat(String lessonId) async {
    try {
      bool asked = await tutoratRepository.askTutorat(lessonId);
      if (asked) {
        emit(AskTutoratSuccess(lessonId: lessonId));
      } else {
        emit(AskTutoratFailed(lessonId: lessonId));
      }
    } catch (ex) {
      emit(AskTutoratFailed(lessonId: lessonId));
    }
  }
}
