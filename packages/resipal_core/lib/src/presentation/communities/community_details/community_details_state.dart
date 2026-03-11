import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class CommunityDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CommunityDetailsInitialState extends CommunityDetailsState {}

class CommunityDetailsLoadingState extends CommunityDetailsState {}

class CommunityDetailsLoadedState extends CommunityDetailsState {
  final CommunityEntity community;

  CommunityDetailsLoadedState(this.community);

  @override
  List<Object?> get props => [community];
}

class CommunityDetailsErrorState extends CommunityDetailsState {}
