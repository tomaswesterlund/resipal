import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/maintenance_contract_model.dart';
import 'package:resipal/data/models/maintenance_fee_model.dart';
import 'package:resipal/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/refs/maintenance_contract_ref.dart';

class MaintenanceRepository {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final MaintenanceContractDataSource _maintenanceContractDataSource;
  final MaintenanceFeeDataSource _maintenanceFeeDataSource;

  MaintenanceRepository(this._maintenanceContractDataSource, this._maintenanceFeeDataSource);

  Future<MaintenanceContractRef> getMaintenanceContractRefById(String id) async {
    final model = await _maintenanceContractDataSource.getMaintenanceContractById(id);
    final ref = MaintenanceContractRef(id: model.id, name: model.name);
    return ref;
  }

  Future<MaintenanceContractEntity> getMaintenanceContractById(String id) async {
    try {
      final model = await _maintenanceContractDataSource.getMaintenanceContractById(id);
      final entity = await _toMaintenanceContractEntity(model);
      return entity;
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'MaintenanceRepository.getMaintenanceContractById',
        stackTrace: s,
        metadata: {'id': id},
      );
      rethrow;
    }
  }

  Future<MaintenanceFeeEntity> getMaintenanceFeeById(String id) async {
    final model = await _maintenanceFeeDataSource.getMaintenanceFeeById(id);
    final entity = _toMaintenanceFeeEntity(model);
    return entity;
  }

  Future<MaintenanceContractEntity> _toMaintenanceContractEntity(MaintenanceContractModel model) async {
    final feeModels = await _maintenanceFeeDataSource.getMaintenanceFeeByContractId(model.id);
    final futures = feeModels.map((f) async => await _toMaintenanceFeeEntity(f));
    final fees = await Future.wait(futures);

    return MaintenanceContractEntity(
      id: model.id,
      name: model.name,
      createdAt: model.createdAt,
      period: model.period,
      amountInCents: model.amountInCents,
      description: model.description,
      fees: fees,
    );
  }

  Future<MaintenanceFeeEntity> _toMaintenanceFeeEntity(MaintenanceFeeModel model) async {
    final contract = await getMaintenanceContractRefById(model.contractId);

    return MaintenanceFeeEntity(
      id: model.id,
      contract: contract,
      createdAt: model.createdAt,
      amountInCents: model.amountInCents,
      dueDate: model.dueDate,
      paymentDate: model.paymentDate,
      fromDate: model.fromDate,
      toDate: model.toDate,
      note: model.note,
    );
  }
}
