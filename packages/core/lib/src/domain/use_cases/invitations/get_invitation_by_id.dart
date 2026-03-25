import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/access_logs/get_access_logs_by_invitation_id.dart';

class GetInvitationById {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  InvitationEntity call(String id) {
    final model = _source.getOptionalById(id);

    if (model == null) {
      throw Exception('Invitation $id not found in cache. Ensure the stream is active.');
    }

    final accessLogs = GetAccessLogsByInvitationId().call(invitationId: id);

    return InvitationEntity(
      id: model.id,
      community: GetCommunityRefById().call(communityId: model.communityId),
      user: GetUserRefById().call(userId: model.userId),
      visitor: GetVisitorRef().fromId(model.visitorId),
      property: GetPropertyRef().call(model.propertyId),
      createdAt: model.createdAt,
      qrCodeToken: model.qrCodeToken,
      fromDate: model.fromDate,
      toDate: model.toDate,
      maxEntries: model.maxEntries,
      logs: accessLogs,
    );
  }
}
