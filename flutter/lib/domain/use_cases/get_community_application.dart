import 'package:resipal/data/models/community_application_model.dart';
import 'package:resipal/domain/entities/community_application_entity.dart';
import 'package:resipal/domain/use_cases/get_community_ref.dart';
import 'package:resipal/domain/use_cases/get_user_ref.dart';

class GetCommunityApplication {
  final GetCommunityRef _getCommunityRef = GetCommunityRef();
  final GetUserRef _getUserRef = GetUserRef();

  CommunityApplicationEntity fromModel(CommunityApplicationModel model) {
    return CommunityApplicationEntity(
      id: model.id,
      createdAt: model.createdAt,
      createdBy: model.createdBy,
      community: _getCommunityRef.fromId(model.communityId),
      user: _getUserRef.fromId(model.userId),
      message: model.message,
    );
  }
}
