import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetMembersByCommunityId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMemberByUserAndCommunityId _getMemberByUserAndCommunityId = GetMemberByUserAndCommunityId();

  List<MemberEntity> call({required String communityId}) {
    final memberships = _source.getByCommunityId(communityId);
    final members = memberships
        .map((x) => _getMemberByUserAndCommunityId(communityId: x.communityId, userId: x.userId))
        .toList();

    return members;
  }
}
