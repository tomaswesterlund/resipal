import 'package:equatable/equatable.dart';
import 'email_sign_in_formstate.dart';

abstract class EmailSignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailSignInInitialState extends EmailSignInState {}

class EmailSignInFormEditingState extends EmailSignInState {
  final EmailSignInFormState formState;
  EmailSignInFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class EmailSignInSubmittingState extends EmailSignInState {}

class EmailSignInSuccessState extends EmailSignInState {}

class EmailSignInInvalidCredentialsState extends EmailSignInState {}

class EmailSignInErrorState extends EmailSignInState {}
