import 'package:equatable/equatable.dart';

class SendWhatsappMessageFormState extends Equatable {
  final String phoneNumber;
  final String message;

  const SendWhatsappMessageFormState({
    this.phoneNumber = '',
    this.message = '',
  });

  bool get canSubmit => phoneNumber.isNotEmpty && message.isNotEmpty;

  SendWhatsappMessageFormState copyWith({
    String? phoneNumber,
    String? message,
  }) {
    return SendWhatsappMessageFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, message];
}