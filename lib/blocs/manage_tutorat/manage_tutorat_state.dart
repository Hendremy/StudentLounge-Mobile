import '../../models/tutorat_model.dart';

abstract class ManageTutoratState {
  ManageTutoratState();

  Map<String, dynamic> get props => {};
}

class ManageTutoratInitial extends ManageTutoratState {}

class ManageTutoratLoading extends ManageTutoratState {}

class ManageTutoratLoaded extends ManageTutoratState {
  final List<Tutorat> tutorats;

  ManageTutoratLoaded({required this.tutorats});

  @override
  Map<String, dynamic> get props => {"tutorats": tutorats};
}

class ManageTutoratLoadFailed extends ManageTutoratState {}
