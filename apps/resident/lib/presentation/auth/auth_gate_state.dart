import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class AuthGateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthGateInitialState extends AuthGateState {}

class AuthGateLoadingState extends AuthGateState {}

class AuthGateUserNotSignedIn extends AuthGateState {}

class AuthGateUserNotOnboarded extends AuthGateState {}

class AuthGateUserHasNoResidentMembership extends AuthGateState {}

class UserSignedIn extends AuthGateState {
  final ResidentMemberEntity resident;

  UserSignedIn(this.resident);
}

class AuthGateErrorState extends AuthGateState {}
