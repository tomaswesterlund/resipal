import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class UserNotSignedIn extends AuthState {}

class UserSignedIn extends AuthState {
  final UserEntity user;

  UserSignedIn(this.user);
}

class ErrorState extends AuthState {}
