import 'package:resipal_core/lib.dart';

class GetPropertyResident {
  ResidentEntity call({required String propertyId}) {
    final property = GetPropertyById().call(propertyId);

    if (property.resident == null) {
      throw Exception('Property ($propertyId) does not have an assigned resident.');
    }

    final resident = GetResidentByUserId().call(property.resident!.id);
    return resident;
  }
}
