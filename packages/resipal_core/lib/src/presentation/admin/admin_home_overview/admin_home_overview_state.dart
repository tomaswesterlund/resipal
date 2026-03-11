import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class AdminHomeOverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminHomeOverviewInitialState extends AdminHomeOverviewState {}

class AdminHomeOverviewLoadingState extends AdminHomeOverviewState {}

class AdminHomeOverviewLoadedState extends AdminHomeOverviewState {
  final CommunityEntity community;
  final UserEntity user;

  AdminHomeOverviewLoadedState({required this.community, required this.user});

  @override
  List<Object?> get props => [community, user];
}

class AdminHomeOverviewEmptyState extends AdminHomeOverviewState {}

class AdminHomeOverviewErrorState extends AdminHomeOverviewState {}
