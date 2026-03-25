import 'package:core/lib.dart';

class ScanInvitationState {}

class ScanInvitationInitialState extends ScanInvitationState {}

class ScanInvitationLoadingState extends ScanInvitationState {}

class ScanInvitationQrCodeNotValidState extends ScanInvitationState {}

class ScanInvitationQrCodeValidState extends ScanInvitationState {
  final InvitationEntity invitation;

  ScanInvitationQrCodeValidState({required this.invitation});
}

class ScanInvitationErrorState extends ScanInvitationState {}
