import 'package:resipal/domain/entities/maintenance_fee_entity.dart';

class MaintenanceContractEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final String period;
  final int amountInCents;
  final String? description;
  final List<MaintenanceFeeEntity> fees;

  MaintenanceContractEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.period,
    required this.amountInCents,
    required this.description,
    required this.fees
  });
}
