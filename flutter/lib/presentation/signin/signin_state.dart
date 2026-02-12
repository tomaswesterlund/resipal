import 'package:resipal/domain/entities/user_entity.dart';

abstract class SigninState {}

class InitialState extends SigninState {}

class UserNotSignedInState extends SigninState {}

class UserSigningInState extends SigninState {}

class UserAlreadySignedInState extends SigninState {
  final UserEntity user;

  UserAlreadySignedInState(this.user);
}

class UserSignedInSuccessfullyAndOnboardedState extends SigninState {
  final UserEntity user;

  UserSignedInSuccessfullyAndOnboardedState(this.user);
}

class UserSignedInSuccessfullyButNotOnboardedState extends SigninState {
  final String userId;

  UserSignedInSuccessfullyButNotOnboardedState({required this.userId});
}

class ErrorState extends SigninState {}
