import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
import 'package:resipal/domain/use_cases/get_contract_maintenance_fees.dart';

class GetOptionalMaintenanceContract {
  final MaintenanceContractDataSource _source = GetIt.I<MaintenanceContractDataSource>();

  MaintenanceContractEntity? call(String? id) {
    if(id == null) return null;

    final model = _source.getById(id);
    if (model == null) return null;

    return MaintenanceContractEntity(
      id: model.id,
      name: model.name,
      createdAt: model.createdAt,
      period: model.period,
      amountInCents: model.amountInCents,
      description: model.description,
      fees: GetContractMaintenanceFees().call(model.id),
    );
  }
}
