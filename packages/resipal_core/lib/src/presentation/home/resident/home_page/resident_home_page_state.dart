import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class ResidentHomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResidentInitialState extends ResidentHomePageState {}

class ResidentLoadingState extends ResidentHomePageState {}

class ResidentLoadedState extends ResidentHomePageState {
  final CommunityEntity community;
  final MemberEntity member;

  ResidentLoadedState(this.community, this.member);

  @override
  List<Object?> get props => [community, member];
}

class ResidentEmptyState extends ResidentHomePageState {}

class ResidentErrorState extends ResidentHomePageState {}
