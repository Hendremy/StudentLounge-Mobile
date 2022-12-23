import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/models/tutorat_model.dart';
import '../../repositories/tutoring_repository.dart';
import 'join_tutorat_events.dart';
import 'join_tutorat_state.dart';

class JoinTutoratBloc extends Bloc<JoinTutoratEvent, JoinTutoratState> {
  final Tutorat tutorat;
  final TutoringRepository tutoratRepository;

  JoinTutoratBloc({required this.tutorat, required this.tutoratRepository})
      : super(TutoratJoinable(tutorat: tutorat)) {
    on<TryJoinTutorat>((event, emit) {
      _joinTutorat();
    });
  }

  _joinTutorat() async {
    emit(JoinTutoratLoading(tutorat: tutorat));
    bool result = await tutoratRepository.acceptTutorat(tutorat.id);
    if (!result) {
      //Envoyer un évenement pour avertir la réussite
      emit(TutoratJoinable(tutorat: tutorat));
    } else {
      //Envoyer un évenement pour avertir l'échec
      emit(TutoratDisable(tutorat: tutorat));
    }
  }
}
