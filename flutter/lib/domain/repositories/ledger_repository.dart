import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/movement_model.dart';
import 'package:resipal/data/sources/movement_data_source.dart';
import 'package:resipal/domain/entities/ledger_entity.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/enums/movement_type.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';

class LedgerRepository {
  final LoggerService _logger;
  final MovementDataSource _movementDataSource;
  final MaintenanceRepository _maintenanceRepository;
  final PaymentRepository _paymentRepository;

  final Map<String, LedgerEntity> _cache = {};

  LedgerRepository(this._logger, this._movementDataSource, this._maintenanceRepository, this._paymentRepository);

  Future initialize() async {
    final firstData = await _movementDataSource.watchMovements().first;
    await _processAndCache(firstData);
    _logger.info('✅ LedgerRepository initialized');
  }

  LedgerEntity getLedgerByUserId(String userId) {
    if (!_cache.containsKey(userId)) {
      _cache[userId] = LedgerEntity(userId: userId);
    }

    return _cache[userId]!;
  }

  Future<Object> _getData(MovementType type, String id) async {
    if (type == MovementType.payment) {
      return _paymentRepository.getPaymentById(id);
    }

    if (type == MovementType.maintenanceFee) {
      return await _maintenanceRepository.getMaintenanceFeeById(id);
    }

    throw UnimplementedError('LedgerRepository._getData');
  }

  Future<MovementEntity> _toEntity(MovementModel model) async {
    try {
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
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'LedgerRepository._toEntity', stackTrace: s);
      rethrow;
    }
  }

  Future<List<LedgerEntity>> _processAndCache(List<MovementModel> models) async {
    try {
      final futures = models.map((model) async {
        final ledger = _cache[model.userId] ??= LedgerEntity(userId: model.userId);

        final movement = await _toEntity(model);
        ledger.addMovement(movement);

        return ledger;
      });

      final list = await Future.wait(futures);
      return list;
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'LedgerRepository._processAndCache', stackTrace: s);
      rethrow;
    }
  }
}
