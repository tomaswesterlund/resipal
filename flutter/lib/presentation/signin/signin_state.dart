import 'package:resipal/domain/entities/user_entity.dart';

abstract class SigninState {}

class InitialState extends SigninState {}

class UserSignedInSuccessfullyState extends SigninState {
  final bool userOnboarded;
  final bool userJoinedCommunity;
  final UserEntity? user;

  UserSignedInSuccessfullyState({required this.userOnboarded, required this.userJoinedCommunity, this.user});
}

class ErrorState extends SigninState {}
