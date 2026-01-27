import 'package:get_it/get_it.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';

class WatchUserMovements {
  final MovementRepository _movementRepository = GetIt.I<MovementRepository>();

  Stream<List<MovementEntity>> call(String userId) {
    return _movementRepository.watchMovementsByUserId(userId);
  }
}