import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchInvitationById {
  final AccessLogDataSource _accessLogDataSource = GetIt.I<AccessLogDataSource>();
  final InvitationDataSource _invitationDataSource = GetIt.I<InvitationDataSource>();

  Stream<InvitationEntity> call(String id) {
    return CombineLatestStream.combine2(
      _accessLogDataSource.watchByInvitationId(id),
      _invitationDataSource.watchById(id),
      (logs, invitation) {
        final invitation = GetInvitationById().call(id);
        return invitation;
      },
    );
  }
}
