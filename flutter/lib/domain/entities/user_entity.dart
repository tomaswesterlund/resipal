import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/community_application_entity.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/ledger_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/domain/refs/community_ref.dart';

class UserEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final CommunityRef community;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final List<CommunityApplicationEntity> applications;
  final List<InvitationEntity> invitations;
  final LedgerEntity ledger;
  final List<PaymentEntity> payments;
  final List<PropertyEntity> properties;

  List<InvitationEntity> get activeInvitations => invitations.where((e) => e.canEnter).toList();

  int get totalBalanceInCents {
    final approvedAndPaidPayments = payments.where((p) => p.status == PaymentStatus.approved);
    final approvedPaymentAmountInCents = approvedAndPaidPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return approvedPaymentAmountInCents;
  }

  int get totalOverdueFeeInCents => properties.fold(0, (sum, property) => sum = sum + property.totalOverdueFeeInCents);

  int get pendingPaymentAmountInCents {
    final pendingPayments = payments.where((p) => p.status == PaymentStatus.pendingReview);
    final pendingAmountInCents = pendingPayments.fold(0, (sum, payment) => sum = sum + payment.amountInCents);
    return pendingAmountInCents;
  }

  const UserEntity({
    required this.id,
    required this.createdAt,
    required this.community,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.applications,
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
    invitations,
    ledger,
    payments,
    properties,
  ];
}
