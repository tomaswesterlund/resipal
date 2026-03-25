import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetMembershipByCommunityIdAndUserId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMembershipById _getMembershipById = GetMembershipById();

  MembershipEntity call({required String communityId, required String userId}) {
    final membership = _source.getByCommunityAndUserId(communityId: communityId, userId: userId);
    return _getMembershipById.call(membership.id);
  }
}
