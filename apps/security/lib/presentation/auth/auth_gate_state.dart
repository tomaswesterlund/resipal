import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

abstract class AuthGateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthGateInitialState extends AuthGateState {}

class AuthGateLoadingState extends AuthGateState {}

class AuthGateUserNotSignedIn extends AuthGateState {}

class AuthGateUserNotOnboarded extends AuthGateState {}

class AuthGateUserHasNoSecurityMembership extends AuthGateState {}

class UserSignedIn extends AuthGateState {
  final MemberEntity member;

  UserSignedIn(this.member);
}

class AuthGateErrorState extends AuthGateState {}
