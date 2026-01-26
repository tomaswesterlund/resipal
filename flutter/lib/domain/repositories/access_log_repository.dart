import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/access_log_data_source.dart';
import 'package:resipal/domain/entities/access_log_entity.dart';
import 'package:resipal/domain/enums/direction_type.dart';
import 'package:resipal/domain/refs/invitation_ref.dart';

class AccessLogRepository {
  final AccessLogDataSource _accessLogDataSource =
      GetIt.I<AccessLogDataSource>();

  Future<List<AccessLogEntity>> getAccessLogsByInvitationId(
    String invitationId,
  ) async {
    final models = await _accessLogDataSource.getAccessLogsByInvitationId(
      invitationId,
    );
    final entities = models
        .map(
          (m) => AccessLogEntity(
            id: m.id,
            invitation: InvitationRef(id: m.invitationId),
            createdAt: m.createdAt,
            direction: DirectionType.fromString(m.direction),
            timestamp: m.timestamp,
          ),
        )
        .toList();

    return entities;
  }
}
