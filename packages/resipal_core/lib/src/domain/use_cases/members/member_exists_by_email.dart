import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class MemberExistsByEmail {
  final MembershipDataSource _membershipSource = GetIt.I<MembershipDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  bool call({required String email}) {
    final communityId = _sessionService.communityId;
    final user = _userDataSource.getOptionalByEmail(email);

    if(user == null) return false;

    final membership = _membershipSource.getOptionalByCommunityAndUserId(communityId: communityId, userId: user.id);
    if(membership == null) return false;

    return true;
  }
}
