import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/domain/enums/maintenance_fee_status.dart';

class MaintenanceContractEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final String period;
  final int amountInCents;
  final String? description;


  MaintenanceContractEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.period,
    required this.amountInCents,
    required this.description,
    // required this.fees
  });
}
