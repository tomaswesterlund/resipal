import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class UserEntity {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final List<InvitationEntity> invitations;
  final List<MovementEntity> movements;
  final List<PaymentEntity> payments;
  final List<PropertyEntity> properties;

  List<InvitationEntity> get activeInvitations =>
      invitations.where((e) => e.isActive).toList();

  int get totalBalanceInCents {
    // Get all expenses - Maintenance fees etc.
    // Get all paid 
    final approvedAndPaidPayments = payments.where((p) => p.status == PaymentStatus.approved);
    final approvedPaymentAmountInCents = approvedAndPaidPayments.fold(0, (sum, payment) => sum = sum + payment.amountInCents);
    return approvedPaymentAmountInCents;
  }

  int get pendingPaymentAmountInCents {
    final pendingPayments = payments.where((p) => p.status == PaymentStatus.pendingReview);
    final pendingAmountInCents = pendingPayments.fold(0, (sum, payment) => sum = sum + payment.amountInCents);
    return pendingAmountInCents;
  }

  UserEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.invitations,
    required this.movements,
    required this.payments,
    required this.properties
  });
}
