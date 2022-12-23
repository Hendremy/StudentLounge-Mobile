import 'package:studentlounge_mobile/models/tutoring_request.dart';

abstract class TutoringRequestState {}

class TutoringRequestInitial extends TutoringRequestState {}

class TutoringRequestLoaded extends TutoringRequestState {
  final TutoringRequest request;

  TutoringRequestLoaded({required this.request});
}

class TutoringRequestLoading extends TutoringRequestState {}

class TutoringRequestLoadFailed extends TutoringRequestState {}
