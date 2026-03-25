import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/entities/members/admin_member_entity.dart';

abstract class AdminHomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminHomeState {}

class AdminLoadingState extends AdminHomeState {}

class AdminLoadedState extends AdminHomeState {
  final AdminMemberEntity admin;
  final CommunityEntity community;
  

  AdminLoadedState(this.admin, this.community);

  @override
  List<Object?> get props => [admin, community];
}

class AdminEmptyState extends AdminHomeState {}

class AdminErrorState extends AdminHomeState {}
