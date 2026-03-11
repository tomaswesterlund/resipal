// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:resipal_core/src/domain/entities/id_entity.dart';
import 'package:resipal_core/src/domain/entities/contract_entity.dart';
import 'package:resipal_core/src/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/src/domain/enums/maintenance_fee_status.dart';
import 'package:resipal_core/src/domain/enums/property_payment_status.dart';
import 'package:resipal_core/src/domain/refs/community_ref.dart';
import 'package:resipal_core/src/domain/refs/user_ref.dart';

class PropertyEntity extends IdEntity {
  final CommunityRef community;
  final UserRef? resident;
  final DateTime createdAt;
  final UserRef createdBy;
  final String name;
  final String? description;
  final ContractEntity? contract;
  final List<MaintenanceFeeEntity> fees;

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'community': community.toMap(),
      'resident': resident?.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy.toMap(),
      'name': name,
      'description': description,
      'contract': contract?.toMap(),
      'fees': fees.map((f) => f.toMap()).toList(),
    };
  }

  int get totalPaidAmountInCents {
    final paid = fees.where((f) => f.status == MaintenanceFeeStatus.paid);
    return paid.fold(0, (sum, fee) => sum = sum + fee.amountInCents);
  }

  int get totalDebtAmountInCents {
    final due = fees.where((f) => f.status == MaintenanceFeeStatus.overdue || f.status == MaintenanceFeeStatus.pending);
    return due.fold(0, (sum, fee) => sum = sum + fee.amountInCents);
  }

  PropertyPaymentStatus get propertyPaymentStatus {
    if (hasOverdueFees) {
      return PropertyPaymentStatus.overdue;
    }

    if (hasPendingFees) {
      return PropertyPaymentStatus.due;
    }

    return PropertyPaymentStatus.settled;
  }

  bool get hasDebt => totalDebtAmountInCents > 0;
  bool get hasOverdueFees => fees.any((x) => x.status == MaintenanceFeeStatus.overdue);
  bool get hasPendingFees => fees.any((x) => x.status == MaintenanceFeeStatus.pending);
  List<MaintenanceFeeEntity> get pendingFees => fees.where((x) => x.status == MaintenanceFeeStatus.pending).toList();
}
