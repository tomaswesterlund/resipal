import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/maintenance_contract_model.dart';
import 'package:resipal_core/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal_core/domain/refs/maintenance_contract_ref.dart';

class GetContractRef {
  final MaintenanceContractDataSource _source = GetIt.I<MaintenanceContractDataSource>();

  MaintenanceContractRef fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Maintenance Contract $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  MaintenanceContractRef fromModel(MaintenanceContractModel model) {
    return MaintenanceContractRef(id: model.id, name: model.name);
  }
}
