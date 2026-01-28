import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/maintenance_contract_model.dart';
import 'package:resipal/data/models/maintenance_fee_model.dart';
import 'package:resipal/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/refs/maintenance_contract_ref.dart';

class MaintenanceRepository {
  final MaintenanceContractDataSource _maintenanceContractDataSource = GetIt.I<MaintenanceContractDataSource>();
  final MaintenanceFeeDataSource _maintenanceFeeDataSource = GetIt.I<MaintenanceFeeDataSource>();

  Future<MaintenanceContractRef> getMaintenanceContractRefById(String id) async {
    final model = await _maintenanceContractDataSource.getMaintenanceContractById(id);
    final ref = MaintenanceContractRef(id: model.id, name: model.name);
    return ref;
  }

  Future<MaintenanceContractEntity> getMaintenanceContractByPropertyId(String propertyId) async {
    final model = await _maintenanceContractDataSource.getMaintenanceContractByPropertyId(propertyId);
    final entity = await _toMaintenanceContractEntity(model);
    return entity;
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

    return MaintenanceContractEntity(id: model.id, name: model.name, createdAt: model.createdAt, period: model.period, amountInCents: model.amountInCents, description: model.description, fees: fees);
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
