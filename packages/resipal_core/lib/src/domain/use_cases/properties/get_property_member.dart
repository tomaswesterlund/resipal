import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetPropertyMember {
  final SessionService _session = GetIt.I<SessionService>();

  MemberEntity call({required String propertyId}) {
    final property = GetPropertyById().call(propertyId);

    if (property.resident == null) {
      throw Exception('Property ($propertyId) does not have an assigned resident.');
    }

    final member = GetMemberByUserAndCommunityId().call(
      communityId: _session.communityId,
      userId: property.resident!.id,
    );
    return member;
  }
}
