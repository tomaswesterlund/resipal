import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetResidentsByCommunity {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetResidentByUserId _getResidentByUserId = GetResidentByUserId();

  List<ResidentEntity> call(String communityId) {
    final memberships = _source.getByCommunityId(communityId);
    final residents = memberships.where((x) => x.isResident);
    final entities = residents.map((x) => _getResidentByUserId(x.userId)).toList();

    return entities;
  }
}
