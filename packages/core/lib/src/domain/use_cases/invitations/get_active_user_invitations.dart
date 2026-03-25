import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetActiveInvitationsByCommunityIdAndUserId {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();
  final GetInvitationById _getInvitationById = GetInvitationById();

  List<InvitationEntity> call({required String communityId, required String userId}) {
    final models = _source.getByCommunityIdAndUserId(communityId: communityId, userId: userId);
    final all = models.map((model) => _getInvitationById.call(model.id)).toList();
    return all.where((i) => i.isActive).toList();
  }
}
