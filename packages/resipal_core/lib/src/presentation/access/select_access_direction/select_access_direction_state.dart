import 'package:resipal_core/lib.dart';

class SelectAccessDirectionState {}

class SelectAccessDirectionInitialState extends SelectAccessDirectionState {}

class SelectAccessDirectionLoggedSuccessfullyState extends SelectAccessDirectionState {
  final InvitationEntity invitation;

  SelectAccessDirectionLoggedSuccessfullyState({required this.invitation});
}

class SelectAccessDirectionErrorState extends SelectAccessDirectionState {}