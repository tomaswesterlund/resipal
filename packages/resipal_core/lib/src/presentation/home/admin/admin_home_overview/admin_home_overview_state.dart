import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/members/admin_member_entity.dart';

abstract class AdminHomeOverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminHomeOverviewInitialState extends AdminHomeOverviewState {}

class AdminHomeOverviewLoadingState extends AdminHomeOverviewState {}

class AdminHomeOverviewLoadedState extends AdminHomeOverviewState {
  final AdminMemberEntity admin;
  final CommunityEntity community;
  

  AdminHomeOverviewLoadedState({required this.admin, required this.community});

  @override
  List<Object?> get props => [admin, community];
}

class AdminHomeOverviewEmptyState extends AdminHomeOverviewState {}

class AdminHomeOverviewErrorState extends AdminHomeOverviewState {}
