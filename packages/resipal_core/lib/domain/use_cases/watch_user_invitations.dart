import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/domain/use_cases/get_invitation.dart';
import 'package:resipal_core/services/logger_service.dart';

class WatchUserInvitations {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();
  final GetInvitation _getInvitation = GetInvitation();

  Stream<List<InvitationEntity>> call(String userId) {
    return _source
        .watchByUserId(userId)
        .map((models) {
          final entities = models.map((model) => _getInvitation.fromModel(model)).toList();
          return entities;
        })
        .handleError((e, s) {
          _logger.logException(
            exception: e,
            featureArea: 'WatchUserInvitations.call',
            stackTrace: s,
            metadata: {'userId': userId},
          );
        });
  }
}
