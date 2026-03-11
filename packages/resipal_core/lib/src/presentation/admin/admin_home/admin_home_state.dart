import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class AdminHomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminHomeState {}

class AdminLoadingState extends AdminHomeState {}

class AdminLoadedState extends AdminHomeState {
  final CommunityEntity community;
  final UserEntity user;

  AdminLoadedState(this.community, this.user);

  @override
  List<Object?> get props => [community];
}

class AdminEmptyState extends AdminHomeState {}

class AdminErrorState extends AdminHomeState {}
