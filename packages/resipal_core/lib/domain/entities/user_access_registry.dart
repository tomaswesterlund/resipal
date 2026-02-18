import 'package:resipal_core/domain/entities/community/community_application_entity.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/enums/community_application_status.dart';

class UserAccessRegistry {
  final List<CommunityApplicationEntity> applications;
  final List<MembershipEntity> memberships;

  List<MembershipEntity> get adminMemberships => memberships.where((x) => x.isAdmin).toList();

  List<CommunityApplicationEntity> get approvedApplications =>
      applications.where((x) => x.status == CommunityApplicationStatus.approved).toList();
  List<CommunityApplicationEntity> get pendingApplications =>
      applications.where((x) => x.status == CommunityApplicationStatus.pendingReview).toList();

  UserAccessRegistry({required this.applications, required this.memberships});
}
