import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/contracts/get_contracts_by_community_id.dart';

class GetCommunityById {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityEntity call(String communityId) {
    final model = _source.getById(communityId);

    if (model == null) {
      throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
    }

    final applications = GetApplicationsByCommunityId().call(communityId: communityId);
    final contracts = GetContractsByCommunityId().call(communityId: communityId);
    final members = GetMembersByCommunityId().call(communityId: communityId);
    final payments = GetPayments().byCommunityId(communityId);
    final properties = GetProperties().byCommunityId(communityId);

    return CommunityEntity(
      id: model.id,
      name: model.name,
      location: model.location,
      description: model.description,
      applications: applications,
      contracts: contracts,
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      memberDirectory: MemberDirectoryEntity(members),
    );
  }
}
