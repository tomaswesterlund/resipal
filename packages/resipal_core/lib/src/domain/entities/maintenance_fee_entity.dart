import 'package:resipal_core/lib.dart';

class MaintenanceFeeEntity {
  final String id;
  final ContractRef contract;
  final PropertyRef property;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime dueDate;
  final DateTime? paymentDate;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  MaintenanceFeeEntity({
    required this.id,
    required this.contract,
    required this.property,
    required this.createdAt,
    required this.amountInCents,
    required this.dueDate,
    required this.paymentDate,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contract': contract.toMap(),
      'property': property.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'amountInCents': amountInCents,
      'dueDate': dueDate.toIso8601String(),
      'paymentDate': paymentDate?.toIso8601String(),
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'note': note,
      'status': status.name,
      'isPaid': isPaid,
    };
  }

  bool get isPaid => paymentDate != null;

  MaintenanceFeeStatus get status {
    final today = DateTime.now();
    if (isPaid) return MaintenanceFeeStatus.paid;
    if (today.isAfter(dueDate)) return MaintenanceFeeStatus.overdue;
    if (today.isAfter(fromDate) || today.isAtSameMomentAs(fromDate)) {
      return MaintenanceFeeStatus.pending;
    }
    return MaintenanceFeeStatus.upcoming;
  }
}
