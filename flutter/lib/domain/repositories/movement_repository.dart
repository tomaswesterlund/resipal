import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/movement_data_source.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/enums/movement_type.dart';

class MovementRepository {
  final MovementDataSource _movementDataSource = GetIt.I<MovementDataSource>();

  Future<List<MovementEntity>> getMovementsByUserId(String userId) async {
    final models = await _movementDataSource.getMovementsByUserId(userId);
    final entities = models.map(
      (m) => MovementEntity(
        id: m.id,
        userId: m.userId,
        createdAt: m.createdAt,
        amountInCents: m.amountInCents,
        type: MovementType.fromString(m.type),
        date: DateTime.now(),
        refSource: m.refSource,
        refId: m.refId,
      ),
    ).toList();

    return entities;
  }
}
