import 'package:equatable/equatable.dart';
import 'register_visitor_form_state.dart';

abstract class RegisterVisitorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterVisitorInitialState extends RegisterVisitorState {}

class RegisterVisitorFormEditingState extends RegisterVisitorState {
  final RegisterVisitorFormState formState;
  RegisterVisitorFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterVisitorSubmittingState extends RegisterVisitorState {}

class RegisterVisitorSuccessState extends RegisterVisitorState {}

class RegisterVisitorErrorState extends RegisterVisitorState {}