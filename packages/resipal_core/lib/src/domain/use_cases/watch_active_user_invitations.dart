import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/invitation_data_source.dart';
import 'package:resipal_core/src/domain/entities/invitation_entity.dart';
import 'package:resipal_core/src/domain/use_cases/get_invitation.dart';
import 'package:resipal_core/src/services/logger_service.dart';

class WatchActiveInvitations {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();
  final GetInvitation _getInvitation = GetInvitation();

  Stream<List<InvitationEntity>> call(String userId) {
    return _source
        .watchByUserId(userId)
        .map((models) {
          final entities = models.map((model) => _getInvitation.fromModel(model)).toList();
          return entities.where((e) => e.isActive).toList();
        })
        .handleError((e, s) {
          _logger.error(
            exception: e,
            featureArea: 'WatchActiveInvitations',
            stackTrace: s,
            metadata: {'userId': userId},
          );
        });
  }
}
