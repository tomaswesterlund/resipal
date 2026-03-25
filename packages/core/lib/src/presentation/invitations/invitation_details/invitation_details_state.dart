import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

abstract class InvitationDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InvitationDetailsInitialState extends InvitationDetailsState {}

class InvitationDetailsLoadingState extends InvitationDetailsState {}

class InvitationDetailsLoadedState extends InvitationDetailsState {
  final InvitationEntity invitation;

  InvitationDetailsLoadedState(this.invitation);

  @override
  List<Object?> get props => [invitation];
}

class InvitationDetailsErrorState extends InvitationDetailsState {}
