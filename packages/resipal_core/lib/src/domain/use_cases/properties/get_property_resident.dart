import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/members/resident_member_entity.dart';

class GetPropertyResident {
  ResidentMemberEntity call({required String propertyId}) {
    final property = GetPropertyById().call(propertyId);

    if (property.resident == null) {
      throw Exception('Property ($propertyId) does not have an assigned resident.');
    }

    

    final resident = GetResidentByCommunityIdAndUserId().call(communityId: property.community.id, userId: property.resident!.id);
    return resident;
  }
}
