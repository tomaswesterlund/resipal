import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetContractsByCommunityId {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();
  final GetContract _getContract = GetContract();

  List<ContractEntity> call({required String communityId}) {
    final models = _source.getByCommunityId(communityId);
    return models.map((x) => _getContract.byId(x.id)).toList();
  }
}