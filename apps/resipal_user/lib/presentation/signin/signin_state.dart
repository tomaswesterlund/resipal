import 'package:resipal_core/domain/entities/user_entity.dart';

abstract class SigninState {}

class InitialState extends SigninState {}

class UserSigningInState extends SigninState {}

class UserSignedInSuccessfullyState extends SigninState {}

class ErrorState extends SigninState {}
