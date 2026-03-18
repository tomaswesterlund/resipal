import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:resipal_core/lib.dart';

class GetAccessLogsByInvitationId {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AccessLogDataSource _source = GetIt.I<AccessLogDataSource>();
  final InvitationDataSource _invitationDataSource = GetIt.I<InvitationDataSource>();

  List<AccessLogEntity> call({required String invitationId}) {
    try {
      final models = _source.getAccessLogsByInvitationId(invitationId);

      final entities = models.map((x) {
        
        return AccessLogEntity(
          id: x.id,
          // visitor: visitorRef,
          createdAt: x.createdAt,
          direction: AccessLogDirection.fromString(x.direction),
          timestamp: x.timestamp,
        );
      }).toList();

      return entities;
    } catch (e, s) {
      _logger.error(featureArea: 'GetAccessLogsByInvitationId', exception: e, stackTrace: s);
      rethrow;
    }
  }
}
