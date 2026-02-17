import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal_core/domain/entities/maintenance_contract_entity.dart';

class GetOptionalMaintenanceContract {
  final MaintenanceContractDataSource _source = GetIt.I<MaintenanceContractDataSource>();

  MaintenanceContractEntity? call(String? id) {
    if (id == null) return null;

    final model = _source.getById(id);
    if (model == null) return null;

    return MaintenanceContractEntity(
      id: model.id,
      name: model.name,
      createdAt: model.createdAt,
      period: model.period,
      amountInCents: model.amountInCents,
      description: model.description,
    );
  }
}
