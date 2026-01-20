import 'package:resipal/domain/enums/movement_types.dart';

class MovementEntity {
  final String id;
  final String userId;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime date;
  final MovementTypes type;
  final String refSource;
  final String refId;

  MovementEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.amountInCents,
    required this.date,
    required this.type,
    required this.refSource,
    required this.refId,
  });
}
