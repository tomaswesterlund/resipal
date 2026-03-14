import 'package:resipal_core/lib.dart';

class ResidentMemberEntity extends MemberEntity {
  final List<InvitationEntity> invitations;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistry;
  final List<VisitorEntity> visitors;

  ResidentMemberEntity({
    required super.name,
    required super.community,
    required super.user,
    required super.isAdmin,
    required super.isResident,
    required super.isSecurity,
    required this.invitations,
    required this.paymentLedger,
    required this.propertyRegistry,
    required this.visitors,
  });

  bool get hasDebt => propertyRegistry.hasDebt;
  int get totalMemberBalanceInCents {
    final a = paymentLedger.totalPaymentBalanceInCents;
    final b = propertyRegistry.totalDebtAmountInCents;
    final c = propertyRegistry.totalPaidAmountInCents;

    return paymentLedger.totalPaymentBalanceInCents -
        propertyRegistry.totalDebtAmountInCents -
        propertyRegistry.totalPaidAmountInCents;
  }
}
