import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/enums/payment_status.dart';
import 'package:resipal_core/domain/refs/community_ref.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class PaymentEntity extends Equatable {
  final String id;
  final CommunityRef community;
  final UserRef user;
  final DateTime createdAt;
  final UserRef createdBy;
  final int amountInCents;
  final PaymentStatus status;
  final DateTime date;
  final String? reference;
  final String? note;
  final String? receiptPath;

  const PaymentEntity({
    required this.id,
    required this.community,
    required this.user,
    required this.createdAt,
    required this.createdBy,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath,
  });

  @override
  List<Object?> get props => [id, community, user, createdAt, createdBy, amountInCents, status, date, reference, note, receiptPath];
}
