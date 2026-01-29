import 'package:resipal/domain/entities/id_entity.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
import 'package:resipal/domain/refs/user_ref.dart';

class PropertyEntity extends IdEntity {
  final UserRef user;
  final DateTime createdAt;
  final String name;
  final String? description;
  final MaintenanceContractEntity contract;

  PropertyEntity({
    required super.id,
    required this.user,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.contract
  });
}
