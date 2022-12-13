import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_events.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_state.dart';
import 'package:studentlounge_mobile/repositories/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleInitial()) {
    on<RetryLoadSchedule>((event, emit) {
      _loadSchedule();
    });

    _loadSchedule();
  }

  _loadSchedule() async {
    emit(ScheduleLoading());
    
  }
}