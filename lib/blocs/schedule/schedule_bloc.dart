import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_events.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_state.dart';
import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/repositories/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;
  late List<Agenda> agendas;

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleInitial()) {
    on<RetryLoadSchedule>((event, emit) {
      _loadSchedule();
    });

    on<ScheduleAppointmentsLoaded>((event, emit) {});

    _loadSchedule();
  }

  _loadSchedule() async {
    emit(ScheduleLoading());
    try {
      List<Agenda> agendas = await scheduleRepository.getUserAgendas();
      emit(ScheduleLoadSuccess(agendas: agendas));
    } on ApiException catch (e) {
      emit(ScheduleLoadFailed(message: e.message));
    } catch (ex) {
      emit(ScheduleLoadFailed(message: 'Erreur inattendue'));
    }
  }
}
