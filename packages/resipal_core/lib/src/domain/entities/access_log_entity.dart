import 'package:resipal_core/src/domain/enums/direction_type.dart';
import 'package:resipal_core/src/domain/refs/invitation_ref.dart';

class AccessLogEntity {
  final String id;
  final InvitationRef invitation;
  final DateTime createdAt;
  final DirectionType direction;
  final DateTime timestamp;

  bool get isEntry => direction == DirectionType.entry;
  bool get isExit => direction == DirectionType.exit;

  AccessLogEntity({
    required this.id,
    required this.invitation,
    required this.createdAt,
    required this.direction,
    required this.timestamp,
  });
}
