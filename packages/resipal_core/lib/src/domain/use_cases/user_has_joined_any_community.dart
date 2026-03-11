import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UserHasJoinedCommunity {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  bool call({required String userId}) {
    final memberships = _source.getByCommunityId(userId);
    if (memberships.isEmpty) return false;

    //TODO: No status check of the membership
    return true;
  }
}
