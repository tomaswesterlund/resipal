import 'package:resipal_core/domain/entities/id_entity.dart';
import 'package:resipal_core/domain/entities/contract_entity.dart';
import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/domain/enums/maintenance_fee_status.dart';
import 'package:resipal_core/domain/refs/community_ref.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class PropertyEntity extends IdEntity {
  final CommunityRef community;
  final UserRef? resident;
  final DateTime createdAt;
  final UserRef createdBy;
  final String name;
  final String? description;
  final ContractEntity? contract;
  final List<MaintenanceFeeEntity> fees;

  int get totalOverdueFeeInCents {
    final overdue = fees.where((f) => f.status == MaintenanceFeeStatus.overdue);
    return overdue.fold(0, (sum, fee) => sum = sum + fee.amountInCents);
  }

  bool get hasDebt => totalOverdueFeeInCents > 0;

  PropertyEntity({
    required super.id,
    required this.community,
    required this.resident,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.description,
    required this.contract,
    required this.fees,
  });
}
