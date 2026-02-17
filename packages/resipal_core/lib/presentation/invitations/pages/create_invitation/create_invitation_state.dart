import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_form_state.dart';

class CreateInvitationState {}

class InitialState extends CreateInvitationState {}

class LoadingState extends CreateInvitationState {}

class FormEditingState extends CreateInvitationState {
  final CreateInvitationFormState formState;

  FormEditingState({required this.formState});
}

class NoPropertiesFoundState extends CreateInvitationState {}

class NoVisitorsFoundState extends CreateInvitationState {}

class FormSubmittingState extends CreateInvitationState {}

class FormSubmittedSuccessfullyState extends CreateInvitationState {}

class ErrorState extends CreateInvitationState {}
