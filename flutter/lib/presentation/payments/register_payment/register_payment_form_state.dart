import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPaymentFormState extends Equatable {
  final double amount;
  final String reference;
  final String note;
  final XFile? receiptImage;

  bool get canSubmit {
    if (amount <= 0) return false;
    if (receiptImage == null) return false;

    return true;
  }

  const RegisterPaymentFormState({
    required this.amount,
    required this.reference,
    required this.note,
    this.receiptImage,
  });

  RegisterPaymentFormState copyWith({
    double? amount,
    String? reference,
    String? note,
    XFile? receiptImage,
  }) {
    return RegisterPaymentFormState(
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      receiptImage: receiptImage ?? this.receiptImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'reference': reference,
      'note': note,
      'hasReceipt': receiptImage != null,
      'receiptPath': receiptImage?.path,
    };
  }

  @override
  List<Object?> get props => [amount, reference, note, receiptImage];
}
