import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

class InvitationEntity extends Equatable {
  final String id;
  final CommunityRef community;
  final UserRef user;
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

    if (now.isAfter(toDate)) {
      return InvitationStatus.expired;
    }

    if (maxEntries != null && usageCount >= maxEntries!) {
      return InvitationStatus.limitReached;
    }

    if (now.isBefore(fromDate)) {
      return InvitationStatus.upcoming;
    }

    return InvitationStatus.active;
  }

  bool get isActive => status == InvitationStatus.active;
  bool get isUpcoming => status == InvitationStatus.upcoming;
  int get remainingEntries => maxEntries == null ? 999 : maxEntries! - usageCount;

  int get usageCount => logs.where((log) => log.direction == AccessLogDirection.entry).length;

  const InvitationEntity({
    required this.id,
    required this.community,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'community_id': community.id, // Assuming Ref objects have an .id property
      'user_id': user.id,
      'visitor_id': visitor.id,
      'property_id': property.id,
      'created_at': createdAt.toIso8601String(),
      'qr_code_token': qrCodeToken,
      'from_date': fromDate.toIso8601String(),
      'to_date': toDate.toIso8601String(),
      'max_entries': maxEntries,
    };
  }

  @override
  List<Object?> get props => [
    id,
    community,
    user,
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
