import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

abstract class ResidentApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResidentApplicationInitialState extends ResidentApplicationState {}

class ResidentApplicationLoadingState extends ResidentApplicationState {}

class ResidentApplicationLoadedState extends ResidentApplicationState {
  final List<ApplicationEntity> applications;

  ResidentApplicationLoadedState({required this.applications});
}

class ResidentApplicationJoinedSuccessfullyState extends ResidentApplicationState {
  final CommunityEntity community;
  final ResidentMemberEntity resident;

  ResidentApplicationJoinedSuccessfullyState({required this.community, required this.resident});
}

class ResidentApplicationErrorState extends ResidentApplicationState {}
