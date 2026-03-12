import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class AdminHomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminHomePageState {}

class AdminLoadingState extends AdminHomePageState {}

class AdminLoadedState extends AdminHomePageState {
  final CommunityEntity community;
  final UserEntity user;

  AdminLoadedState(this.community, this.user);

  @override
  List<Object?> get props => [community];
}

class AdminEmptyState extends AdminHomePageState {}

class AdminErrorState extends AdminHomePageState {}
