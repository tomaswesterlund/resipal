import 'package:equatable/equatable.dart';
import 'package:resipal_core/src/domain/entities/access_log_entity.dart';
import 'package:resipal_core/src/domain/enums/invitation_status.dart';
import 'package:resipal_core/src/domain/refs/property_ref.dart';
import 'package:resipal_core/src/domain/refs/visitor_ref.dart';

class InvitationEntity extends Equatable {
  final String id;
  final String userId;
  final VisitorRef visitor;
  final PropertyRef property;
  final DateTime createdAt;
  final String qrCodeToken;
  final DateTime fromDate;
  final DateTime toDate;
  final int? maxEntries;
  final List<AccessLogEntity> logs;

  InvitationStatus get status {
    final now = DateTime.now();

    if (now.isAfter(toDate) || (maxEntries != null && usageCount >= maxEntries!)) {
      return InvitationStatus.expired;
    }

    if (now.isBefore(fromDate)) {
      return InvitationStatus.upcoming;
    }

    return InvitationStatus.active;
  }

  bool get isActive => status == InvitationStatus.active;
  bool get isUpcoming => status == InvitationStatus.upcoming;
  int get remainingEntries => maxEntries == null ? 999 : maxEntries! - usageCount;

  int get usageCount => logs.where((log) => log.isEntry).length;

  const InvitationEntity({
    required this.id,
    required this.userId,
    required this.visitor,
    required this.property,
    required this.createdAt,
    required this.qrCodeToken,
    required this.fromDate,
    required this.toDate,
    required this.maxEntries,
    required this.logs,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    visitor,
    property,
    createdAt,
    qrCodeToken,
    fromDate,
    toDate,
    maxEntries,
    logs,
  ];
}
