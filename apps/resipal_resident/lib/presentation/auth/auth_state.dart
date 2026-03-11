import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthUserNotSignedIn extends AuthState {}

class AuthUserSignedIn extends AuthState {
  final ResidentEntity resident;

  AuthUserSignedIn(this.resident);
}

class AuthErrorState extends AuthState {}
