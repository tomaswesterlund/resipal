import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class PaymentEntity {
  final String id;
  final UserRef user;
  final DateTime createdAt;
  final int amountInCents;
  final PaymentStatus status;
  final DateTime date;
  final String? reference;
  final String? note;
  final String? receiptPath;

  PaymentEntity({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath,
  });
}
