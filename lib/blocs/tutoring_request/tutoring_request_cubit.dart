import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/tutoring_request/tutoring_request_state.dart';
import 'package:studentlounge_mobile/models/tutoring_request.dart';
import 'package:studentlounge_mobile/repositories/tutoring_repository.dart';

class TutoringRequestCubit extends Cubit<TutoringRequestState> {
  final TutoringRepository tutoringRepository;
  TutoringRequestCubit({required this.tutoringRepository})
      : super(TutoringRequestInitial());

  Future<void> loadTutoringRequest({lessonId}) async {
    emit(TutoringRequestLoading());
    try {
      TutoringRequest req = await tutoringRepository
          .getUserTutoringRequestStatus(lessonId: lessonId);
      emit(TutoringRequestLoaded(request: req));
    } catch (ex) {
      emit(TutoringRequestLoadFailed());
    }
  }
}
