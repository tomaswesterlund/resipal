import 'package:equatable/equatable.dart';
import 'send_whatsapp_message_form_state.dart';

abstract class SendWhatsappMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendWhatsappMessageInitialState extends SendWhatsappMessageState {}

class SendWhatsappMessageFormEditingState extends SendWhatsappMessageState {
  final SendWhatsappMessageFormState formState;

  SendWhatsappMessageFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class SendWhatsappMessageSubmittingState extends SendWhatsappMessageState {}

class SendWhatsappMessageSuccessState extends SendWhatsappMessageState {}

class SendWhatsappMessageErrorState extends SendWhatsappMessageState {
  final String? error;
  SendWhatsappMessageErrorState({this.error});

  @override
  List<Object?> get props => [error];
}