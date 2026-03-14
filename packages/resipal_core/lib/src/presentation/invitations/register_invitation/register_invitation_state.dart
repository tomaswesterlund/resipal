import 'package:equatable/equatable.dart';
import 'register_invitation_form_state.dart';

abstract class RegisterInvitationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInvitationInitialState extends RegisterInvitationState {}

class RegisterInvitationFormEditingState extends RegisterInvitationState {
  final RegisterInvitationFormState formState;
  RegisterInvitationFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterInvitationSubmittingState extends RegisterInvitationState {}
class RegisterInvitationSuccessState extends RegisterInvitationState {}
class RegisterInvitationErrorState extends RegisterInvitationState {}