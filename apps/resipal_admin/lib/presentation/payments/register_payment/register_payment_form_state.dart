import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/domain/entities/resident_entity.dart';

class RegisterPaymentFormState extends Equatable {
  final ResidentEntity? resident;
  final double amount;
  final String reference;
  final String note;
  final XFile? receiptImage;

  const RegisterPaymentFormState({
    this.resident,
    this.amount = 0.0,
    this.reference = '',
    this.note = '',
    this.receiptImage,
  });

  bool get canSubmit => resident != null && amount > 0 && reference.isNotEmpty;

  int get amountInCents => (amount * 100).toInt();

  RegisterPaymentFormState copyWith({
    ResidentEntity? resident,
    double? amount,
    String? reference,
    String? note,
    XFile? receiptImage,
  }) {
    return RegisterPaymentFormState(
      resident: resident ?? this.resident,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      receiptImage: receiptImage ?? this.receiptImage,
    );
  }

  @override
  List<Object?> get props => [resident, amount, reference, note, receiptImage];
}
