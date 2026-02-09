import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/access_log_entity.dart';
import 'package:resipal/domain/refs/property_ref.dart';
import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/refs/visitor_ref.dart';

class InvitationEntity extends Equatable {
  final String id;
  final UserRef user;
  final VisitorRef visitor;
  final PropertyRef property;
  final DateTime createdAt;
  final String qrCodeToken;
  final DateTime fromDate;
  final DateTime toDate;
  final int maxEntries;
  final List<AccessLogEntity> logs;

  bool get isActive => canEnter || isUpcoming;

  bool get isUpcoming => fromDate.isAfter(DateTime.now());

  bool get canEnter {
    final now = DateTime.now();
    final isAfterOrEqualFrom = now.isAfter(fromDate) || now.isAtSameMomentAs(fromDate);
    final isBeforeOrEqualTo = now.isBefore(toDate) || now.isAtSameMomentAs(toDate);

    final hasEntriesLeft = usageCount < maxEntries;
    return isWithinDateRange && hasEntriesLeft && isAfterOrEqualFrom && isBeforeOrEqualTo;
  }

  int get remainingEntries => maxEntries - usageCount;

  bool get isWithinDateRange {
    final now = DateTime.now();
    return now.isAfter(fromDate) && now.isBefore(toDate);
  }

  int get usageCount => logs.where((log) => log.isEntry).length;

  InvitationEntity({
    required this.id,
    required this.user,
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
  List<Object?> get props => [id, user, visitor, property, createdAt, qrCodeToken, fromDate, toDate, maxEntries, logs];
}
