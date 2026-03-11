import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/contract_data_source.dart';
import 'package:resipal_core/src/domain/entities/contract_entity.dart';

class GetContract {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();

  ContractEntity byId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Contract $id not found in cache. Ensure the stream is active.');
    }

    return ContractEntity(
      id: model.id,
      name: model.name,
      createdAt: model.createdAt,
      period: model.period,
      amountInCents: model.amountInCents,
      description: model.description,
    );
  }

  ContractEntity? optionalById(String? id) {
    if (id == null) return null;

    final model = _source.getById(id);
    if (model == null) return null;

    return byId(id);
  }
}
