import 'package:get_it/get_it.dart';
import 'package:core/src/data/models/contract/upsert_contract_model.dart';
import 'package:core/src/data/sources/contract_data_source.dart';
import 'package:core/src/domain/typedefs.dart';

class CreateContract {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();

  Future<ContractId> call({
    required String communityId,
    required String name,
    required int amountInCents,
    required String period,
    required String? description,
  }) async {
    final model = UpsertContractModel(
      communityId: communityId,
      name: name,
      period: period,
      amountInCents: amountInCents,
      description: description,
    );
    return await _source.upsert(model);
  }
}
