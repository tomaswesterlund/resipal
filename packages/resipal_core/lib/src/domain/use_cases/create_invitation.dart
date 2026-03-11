import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/invitation_data_source.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_signed_in_user.dart';
import 'package:resipal_core/src/services/session_service.dart';

class CreateInvitation {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future call({
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final user = await GetSignedInUser().call();

    await _source.createInvitation(
      communityId: _sessionService.communityId,
      userId: user.id,
      propertyId: propertyId,
      visitorId: visitorId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
