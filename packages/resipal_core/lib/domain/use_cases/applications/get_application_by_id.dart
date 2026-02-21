// import 'package:resipal_core/data/models/application_model.dart';
// import 'package:resipal_core/domain/entities/application_entity.dart';
// import 'package:resipal_core/domain/enums/community_application_status.dart';
// import 'package:resipal_core/domain/use_cases/communities/get_community_ref.dart';
// import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

// class GetApplication {
//   final GetCommunityRef _getCommunityRef = GetCommunityRef();
//   final GetUserRef _getUserRef = GetUserRef();

//   ApplicationEntity fromModel(ApplicationModel model) {
//     return ApplicationEntity(
//       id: model.id,
//       createdAt: model.createdAt,
//       createdBy: model.createdBy,
//       community: _getCommunityRef.fromId(model.communityId),
//       user: _getUserRef.fromId(model.userId),
//       status: ApplicationStatus.fromString(model.status),
//       message: model.message,
//     );
//   }
// }
