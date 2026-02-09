import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';

abstract class UserAccessState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserAccessState {}

class LoadingState extends UserAccessState {}

class LoadedState extends UserAccessState {
  final List<InvitationEntity> activeInvitations;
  final List<VisitorEntity> visitors;

  LoadedState(this.activeInvitations, this.visitors);

  @override
  List<Object?> get props => [activeInvitations, visitors];
}

class ErrorState extends UserAccessState {}
