import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/domain/use_cases/get_signed_in_user.dart';

class CreateInvitation {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future call({
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final user = GetSignedInUser().call();

    await _source.createInvitation(
      communityId: user.community.id,
      userId: user.id,
      propertyId: propertyId,
      visitorId: visitorId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
