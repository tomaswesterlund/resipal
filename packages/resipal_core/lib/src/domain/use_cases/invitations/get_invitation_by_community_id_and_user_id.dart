import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/invitation_data_source.dart';
import 'package:resipal_core/src/domain/entities/invitation_entity.dart';
import 'package:resipal_core/src/domain/use_cases/get_invitation.dart';

class GetInvitationByCommunityIdAndUserId {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();
  final GetInvitation _getInvitation = GetInvitation();

  List<InvitationEntity> call({required String communityId, required String userId}) {
    final models = _source.getByCommunityIdAndUserId(communityId: communityId, userId: userId);
    return models.map((model) => _getInvitation.fromModel(model)).toList();
  }
}
