import 'package:resipal_core/domain/enums/movement_type.dart';

class MovementEntity {
  final String id;
  final String userId;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime date;
  final MovementType type;
  final String refId;
  final Object data;

  MovementEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.amountInCents,
    required this.date,
    required this.type,
    required this.refId,
    required this.data
  });
}
