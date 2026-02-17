import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/domain/use_cases/get_invitation.dart';

class GetUserInvitations {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();
  final GetInvitation _getInvitation = GetInvitation();

  List<InvitationEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    return models.map((model) => _getInvitation.fromModel(model)).toList();
  }
}
