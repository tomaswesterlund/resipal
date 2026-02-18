import 'package:resipal_core/domain/entities/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';

class CommunityEntity {
  final String id;
  final String name;
  final String key;
  final String location;
  final String? description;
  final PaymentLedgerEntity ledger;
  final PropertyRegistry registry;

  CommunityEntity({
    required this.id,
    required this.name,
    required this.key,
    required this.location,
    required this.description,
    required this.ledger,
    required this.registry,
  });
}
