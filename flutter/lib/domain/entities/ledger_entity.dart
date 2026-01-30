import 'package:resipal/domain/entities/movement_entity.dart';

class LedgerEntity {
  final String userId;
  List<MovementEntity> movements = [];

  LedgerEntity({required this.userId});

  void addMovement(MovementEntity movement) => movements.add(movement);

}
