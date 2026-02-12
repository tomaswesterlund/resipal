import 'package:resipal/domain/entities/id_entity.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';
import 'package:resipal/domain/refs/user_ref.dart';

class PropertyEntity extends IdEntity {
  final String communityId;
  final UserRef? owner;
  final DateTime createdAt;
  final String name;
  final String? description;
  final MaintenanceContractEntity? contract;
  final List<MaintenanceFeeEntity> fees;

  int get totalOverdueFeeInCents {
    final overdue = fees.where((f) => f.status == MaintenanceFeeStatus.overdue);
    return overdue.fold(0, (sum, fee) => sum = sum + fee.amountInCents);
  }

  bool get hasDebt => totalOverdueFeeInCents > 0;

  PropertyEntity({
    required super.id,
    required this.communityId,
    required this.owner,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.contract,
    required this.fees,
  });
}
