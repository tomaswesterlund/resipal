// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:resipal_core/domain/entities/community/community_directory_entity.dart';
import 'package:resipal_core/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';

class CommunityEntity {
  final String id;
  final String name;
  final String location;
  final String? description;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistry;
  final CommunityDirectoryEntity directory;

  CommunityEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.paymentLedger,
    required this.propertyRegistry,
    required this.directory,
  });
}
