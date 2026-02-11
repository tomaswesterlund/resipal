import 'package:resipal/domain/enums/maintenance_fee_status.dart';
import 'package:resipal/domain/refs/maintenance_contract_ref.dart';

class MaintenanceFeeEntity {
  final String id;
  final String contractId;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime dueDate;
  final DateTime? paymentDate;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  bool get isPaid => paymentDate != null;

  MaintenanceFeeStatus get status {
    final today = DateTime.now();
    if (isPaid) return MaintenanceFeeStatus.paid;
    if (dueDate.isAfter(today)) return MaintenanceFeeStatus.upcoming;
    if (today.isAfter(fromDate) && today.isBefore(dueDate)) {
      return MaintenanceFeeStatus.pending;
    }
    if (dueDate.isBefore(today)) return MaintenanceFeeStatus.overdue;
    return MaintenanceFeeStatus.overdue;
  }

  MaintenanceFeeEntity({
    required this.id,
    required this.contractId,
    required this.createdAt,
    required this.amountInCents,
    required this.dueDate,
    required this.paymentDate,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });
}
