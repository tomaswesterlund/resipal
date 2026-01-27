import 'package:resipal/domain/refs/maintenance_contract_ref.dart';

class MaintenanceFeeEntity {
  final String id;
  final MaintenanceContractRef contract;
  final DateTime createdAt;
  final int amountInCents;
  final String status;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  MaintenanceFeeEntity({
    required this.id,
    required this.contract,
    required this.createdAt,
    required this.amountInCents,
    required this.status,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });
}