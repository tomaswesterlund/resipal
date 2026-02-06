import 'package:resipal/domain/entities/id_entity.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';

class UserPropertyEntity extends IdEntity {
  final String communityId;
  final String ownerId;
  final DateTime createdAt;
  final String name;
  final String? description;
  final MaintenanceContractEntity contract;

  bool get hasDebt => totalOverdueFeeInCents > 0;
  int get totalOverdueFeeInCents => contract.totalOverdueFeeInCents;

  UserPropertyEntity({
    required super.id,
    required this.communityId,
    required this.ownerId,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.contract,
  });
}
