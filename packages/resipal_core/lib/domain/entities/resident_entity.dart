import 'package:resipal_core/domain/entities/id_entity.dart';
import 'package:resipal_core/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class ResidentEntity extends IdEntity {
  final UserRef user;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistery;

  ResidentEntity({required super.id, required this.user, required this.paymentLedger, required this.propertyRegistery});
}
