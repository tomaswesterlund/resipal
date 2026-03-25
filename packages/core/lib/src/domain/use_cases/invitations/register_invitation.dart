import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:uuid/uuid.dart';

class RegisterInvitation {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future call({
    required String communityId,
    required String userId,
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
    required int? maxEntries,
  }) async {
    final qrCodeToken = Uuid().v4();
    
    await _source.upsert(
      communityId: communityId,
      userId: userId,
      propertyId: propertyId,
      visitorId: visitorId,
      qrCodeToken: qrCodeToken,
      fromDate: fromDate,
      toDate: toDate,
      maxEntries: maxEntries,
    );
  }
}
