import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/models/contract_model.dart';
import 'package:resipal_core/src/data/sources/contract_data_source.dart';
import 'package:resipal_core/src/domain/refs/contract_ref.dart';

class GetContractRef {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();

  ContractRef fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Maintenance Contract $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  ContractRef fromModel(ContractModel model) {
    return ContractRef(id: model.id, name: model.name);
  }
}
