import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetSignedInMember {
  final SessionService _sessionService = GetIt.I<SessionService>();

  MemberEntity call() {
    final member = GetMemberByUserAndCommunityId().call(communityId: _sessionService.communityId, userId: _sessionService.userId);
    return member;
    
  }
}