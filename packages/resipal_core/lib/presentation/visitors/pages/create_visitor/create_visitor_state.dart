import 'package:equatable/equatable.dart';
import 'package:resipal_core/presentation/visitors/pages/create_visitor/create_visitor_form_state.dart';

abstract class CreateVisitorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CreateVisitorState {}

class LoadingState extends CreateVisitorState {}

class NoPropertiesFoundState extends CreateVisitorState {}

class FormEditingState extends CreateVisitorState {
  final CreateVisitorFormState formState;

  FormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class FormSubmittingState extends CreateVisitorState {}

class FormSubmittedSuccessfullyState extends CreateVisitorState {}

class ErrorState extends CreateVisitorState {}
