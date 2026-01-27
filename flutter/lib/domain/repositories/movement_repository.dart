import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/movement_model.dart';
import 'package:resipal/data/sources/movement_data_source.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/enums/movement_type.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';

class MovementRepository {
  final MovementDataSource _movementDataSource = GetIt.I<MovementDataSource>();

  Stream<List<MovementEntity>> watchMovementsByUserId(String userId) {
    return _movementDataSource.watchMovementsByUserId(userId).asyncMap((
      models,
    ) async {
      final futures = models.map((model) => _toEntity(model)).toList();
      return await Future.wait(futures);
    });
  }

  Future<List<MovementEntity>> getMovementsByUserId(String userId) async {
    final models = await _movementDataSource.getMovementsByUserId(userId);
    final futures = models.map((m) async => _toEntity(m)).toList();

    final entities = Future.wait(futures);
    return entities;
  }

  Future<Object> _getData(MovementType type, String id) async {
    if (type == MovementType.payment) {
      final PaymentRepository paymentRepository = GetIt.I<PaymentRepository>();
      return await paymentRepository.getPaymentById(id);
    }

    if(type == MovementType.maintenanceFee) {
      final MaintenanceRepository maintenanceRepository = GetIt.I<MaintenanceRepository>();
      return await maintenanceRepository.getMaintenanceFeeById(id);
    }

    throw UnimplementedError('MovementRepository._getData');
  }

  Future<MovementEntity> _toEntity(MovementModel model) async {
    final type = MovementType.fromString(model.type);
    
    return MovementEntity(
      id: model.id,
      userId: model.userId,
      createdAt: model.createdAt,
      amountInCents: model.amountInCents,
      type: type,
      date: DateTime.now(),
      refId: model.refId,
      data: await _getData(type, model.refId),
    );
  }
}
