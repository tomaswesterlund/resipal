import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetResidentByPropertyId {
  final SessionService _session = GetIt.I<SessionService>();

  ResidentMemberEntity call({required String propertyId}) {
    final property = GetPropertyById().call(propertyId);

    if (property.resident == null) {
      throw Exception('Property ($propertyId) does not have an assigned resident.');
    }

    final resident = GetResidentByCommunityIdAndUserId().call(
      communityId: _session.communityId,
      userId: property.resident!.id,
    );

    return resident;
  }
}
