import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

abstract class UserActiveInvitationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserActiveInvitationsState {}

class LoadingState extends UserActiveInvitationsState {}

class LoadedState extends UserActiveInvitationsState {
  final List<InvitationEntity> invitations;

  LoadedState(this.invitations);

  @override
  List<Object?> get props => [invitations];
}

class ErrorState extends UserActiveInvitationsState {}
