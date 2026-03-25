import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/data/models/access/upsert_access_log_model.dart';
import 'package:core/src/domain/enums/access_log_direction.dart';

class LogAccessEvent {
  final AccessLogDataSource _source = GetIt.I<AccessLogDataSource>();

  Future call(InvitationEntity invitation, AccessLogDirection direction) async {
    if (invitation.status != InvitationStatus.active) {
      throw Exception('Invitation is not active!');
    }

    final upsert = UpsertAccessLogModel(
      communityId: invitation.community.id,
      invitationId: invitation.id,
      direction: direction.toString(),
      timestamp: DateTime.now(),
    );

    await _source.upsert(upsert);
  }
}
