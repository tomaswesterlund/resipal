import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/domain/entities/ledger_entity.dart';
import 'package:resipal_core/domain/entities/payment_entity.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/user_membership.dart';
import 'package:resipal_core/domain/enums/payment_status.dart';

class UserEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final UserMembership membership;
  final List<InvitationEntity> invitations;
  final LedgerEntity ledger;
  final List<PaymentEntity> payments;
  final List<PropertyEntity> properties;

  List<InvitationEntity> get activeInvitations =>
      invitations.where((e) => e.canEnter).toList();

  bool get hasDebt => properties.any((p) => p.hasDebt);

  int get totalBalanceInCents {
    final approvedAndPaidPayments = payments.where(
      (p) => p.status == PaymentStatus.approved,
    );
    final approvedPaymentAmountInCents = approvedAndPaidPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return approvedPaymentAmountInCents;
  }

  int get totalOverdueFeeInCents => properties.fold(
    0,
    (sum, property) => sum = sum + property.totalOverdueFeeInCents,
  );

  List<PaymentEntity> get pendingPayments =>
      payments.where((p) => p.status == PaymentStatus.pendingReview).toList();

  int get pendingPaymentAmountInCents {
    final pendingAmountInCents = pendingPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return pendingAmountInCents;
  }

  const UserEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    // required this.applications,
    required this.membership,
    required this.invitations,
    required this.ledger,
    required this.payments,
    required this.properties,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    phoneNumber,
    emergencyPhoneNumber,
    email,
    membership,
    invitations,
    ledger,
    payments,
    properties,
  ];
}
