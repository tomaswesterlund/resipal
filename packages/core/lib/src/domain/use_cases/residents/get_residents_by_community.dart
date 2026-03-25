import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetResidentsByCommunity {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetResidentByCommunityIdAndUserId _getResidentByCommunityIdAndUserId = GetResidentByCommunityIdAndUserId();

  List<ResidentMemberEntity> call(String communityId) {
    final memberships = _source.getByCommunityId(communityId);
    final residents = memberships.where((x) => x.isResident);

    final entities = residents
        .map((x) => _getResidentByCommunityIdAndUserId.call(communityId: x.communityId, userId: x.userId))
        .toList();

    return entities;
  }
}
