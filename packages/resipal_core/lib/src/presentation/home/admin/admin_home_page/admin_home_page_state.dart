import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/members/admin_member_entity.dart';

abstract class AdminHomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminHomePageState {}

class AdminLoadingState extends AdminHomePageState {}

class AdminLoadedState extends AdminHomePageState {
  final AdminMemberEntity admin;
  final CommunityEntity community;
  

  AdminLoadedState(this.admin, this.community);

  @override
  List<Object?> get props => [admin, community];
}

class AdminEmptyState extends AdminHomePageState {}

class AdminErrorState extends AdminHomePageState {}
