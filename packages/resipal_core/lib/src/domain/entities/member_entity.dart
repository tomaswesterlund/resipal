// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:resipal_core/lib.dart';

class MemberEntity {
  final String name;
  final CommunityRef community;
  final UserRef user;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistry;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MemberEntity({
    required this.name,
    required this.community,
    required this.user,
    required this.paymentLedger,
    required this.propertyRegistry,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  int get totalMemberBalanceInCents => paymentLedger.totalPaymentBalanceInCents - propertyRegistry.totalDebtAmountInCents - propertyRegistry.totalPaidAmountInCents;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'community': community.toMap(),
      'user': user.toMap(),
      'paymentLedger': paymentLedger.toMap(),
      'propertyRegistry': propertyRegistry.toMap(),
      'isAdmin': isAdmin,
      'isResident': isResident,
      'isSecurity': isSecurity,
    };
  }
}
