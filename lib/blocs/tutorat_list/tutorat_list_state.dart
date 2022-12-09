import '../../models/tutorat_model.dart';

abstract class TutoratListState {}

class TutoratListInitial extends TutoratListState {}

class TutoratListLoading extends TutoratListState {}

class TutoratListLoadingFailed extends TutoratListState {
  final String error;

  TutoratListLoadingFailed({required this.error});
}

class TutoratListLoaded extends TutoratListState {
  final List<Tutorat> tutoratList;

  TutoratListLoaded({required this.tutoratList});
}
