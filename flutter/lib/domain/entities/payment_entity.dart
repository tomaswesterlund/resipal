import 'package:equatable/equatable.dart';
import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class PaymentEntity extends Equatable {
  final String id;
  final String userId;
  final DateTime createdAt;
  final int amountInCents;
  final PaymentStatus status;
  final DateTime date;
  final String? reference;
  final String? note;
  final String? receiptPath;

  const PaymentEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    createdAt,
    amountInCents,
    status,
    date,
    reference,
    note,
    receiptPath,
  ];
}
