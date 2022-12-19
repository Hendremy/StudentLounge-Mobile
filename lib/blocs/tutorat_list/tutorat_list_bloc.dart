import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/tutorat_list/tutorat_list_event.dart';
import 'package:studentlounge_mobile/blocs/tutorat_list/tutorat_list_state.dart';
import 'package:studentlounge_mobile/models/tutorat_model.dart';

import '../../repositories/tutorat_repository.dart';

class TutoratListBloc extends Bloc<TutoratListEvent, TutoratListState> {
  final TutoringRepository tutoratRepository;
  List<Tutorat> tutoratList = [];
  final String lessonId;

  TutoratListBloc({required this.tutoratRepository, required this.lessonId})
      : super(TutoratListInitial()) {
    on<TutoratSelected>((event, emit) async {
      emit(TutoratListLoading());
      try {
        await _getTutorat(event, emit);
      } catch (error) {
        emit(TutoratListLoadingFailed(error: error.toString()));
      }
    });

    on<TutoratListUpdated>((event, emit) =>
        emit(TutoratListLoaded(tutoratList: event.tutoratList)));

    on<TutoratListLoadRetry>((event, emit) => _getUserTutorats(lessonId));

    _getUserTutorats(lessonId);
  }

  Future<void> _getTutorat(
      TutoratListEvent event, Emitter<TutoratListState> emit) async {}

  Future<void> _getUserTutorats(lessonId) async {
    emit(TutoratListLoading());
    List<Tutorat>? loadedTutorats =
        await tutoratRepository.getTutorats(lessonId: lessonId);
    if (loadedTutorats != null) {
      tutoratList = List.from(loadedTutorats);
      emit(TutoratListLoaded(tutoratList: tutoratList));
    } else {
      emit(TutoratListLoadingFailed(
          error: "Erreur lors du chargement des cours"));
    }
  }
}
