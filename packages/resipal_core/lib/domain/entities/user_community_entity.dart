import 'package:resipal_core/domain/enums/community_application_status.dart';

class UserCommunityEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String userId;
  final String communityId;
  final ApplicationStatus status;
  final DateTime joinedAt;

  UserCommunityEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.userId,
    required this.communityId,
    required this.status,
    required this.joinedAt,
  });
}
