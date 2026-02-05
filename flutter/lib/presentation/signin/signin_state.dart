import 'package:resipal/domain/entities/user_entity.dart';

abstract class SigninState {}

class InitialState extends SigninState {}

class UserSignedInSuccessfullyState extends SigninState {
  final bool userOnboarded;
  final UserEntity? user;

  UserSignedInSuccessfullyState({required this.userOnboarded, this.user});
}

class ErrorState extends SigninState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}
