import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/contract_data_source.dart';
import 'package:core/src/domain/entities/contract_entity.dart';
import 'package:core/src/domain/use_cases/contracts/get_contract.dart';

class GetContractsByCommunity {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();
  final GetContract _getContract = GetContract();

  List<ContractEntity> call(String communityId) {
    final contracts = _source.getByCommunityId(communityId);
    final list = contracts.map((x) => _getContract.byId(x.id)).toList();
    return list;
  }
}
