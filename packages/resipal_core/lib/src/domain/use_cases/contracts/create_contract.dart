import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/contract_data_source.dart';
import 'package:resipal_core/src/domain/typedefs.dart';

class CreateContract {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();

  Future<ContractId> call({
    required String communityId,
    required String name,
    required int amountInCents,
    required String period,
    required String? description,
  }) async => _source.createContract(
    communityId: communityId,
    name: name,
    amountInCents: amountInCents,
    period: period,
    description: description,
  );
}
