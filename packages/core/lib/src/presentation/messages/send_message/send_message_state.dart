import 'package:equatable/equatable.dart';
import 'send_message_form_state.dart';

abstract class SendMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessageInitialState extends SendMessageState {}

class SendMessageFormEditingState extends SendMessageState {
  final SendMessageFormState formState;

  SendMessageFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class SendMessageSubmittingState extends SendMessageState {}

class SendMessageSuccessState extends SendMessageState {}

class SendMessageErrorState extends SendMessageState {}
