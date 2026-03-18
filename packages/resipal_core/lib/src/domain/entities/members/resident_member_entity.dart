import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/access_registery.dart';

class ResidentMemberEntity extends MemberEntity {
  final AccessRegistry accessRegistry;
  final List<NotificationEntity> notifications;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistry;

  ResidentMemberEntity({
    required super.name,
    required super.community,
    required super.user,
    required super.isAdmin,
    required super.isResident,
    required super.isSecurity,
    required this.accessRegistry,
    required this.notifications,
    required this.paymentLedger,
    required this.propertyRegistry,
  });

  bool get hasDebt => propertyRegistry.hasDebt;
  int get totalMemberBalanceInCents {
    return paymentLedger.totalPaymentBalanceInCents -
        propertyRegistry.totalDebtAmountInCents -
        propertyRegistry.totalPaidAmountInCents;
  }
}
