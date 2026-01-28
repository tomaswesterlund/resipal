import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';

class MaintenanceContractEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final String period;
  final int amountInCents;
  final String? description;
  final List<MaintenanceFeeEntity> fees;

  int get totalOverdueFeeInCents {
    final overdue = fees.where((f) => f.status == MaintenanceFeeStatus.overdue);
    return overdue.fold(0, (sum, fee) => sum = sum + fee.amountInCents);
  }

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
