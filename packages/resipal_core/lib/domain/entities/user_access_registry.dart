import 'package:resipal_core/domain/entities/application_entity.dart';
import 'package:resipal_core/domain/entities/membership_entity.dart';
import 'package:resipal_core/domain/enums/community_application_status.dart';

class UserAccessRegistry {
  final List<ApplicationEntity> applications;
  final List<MembershipEntity> memberships;

  List<MembershipEntity> get adminMemberships => memberships.where((x) => x.isAdmin).toList();

  List<ApplicationEntity> get approvedApplications =>
      applications.where((x) => x.status == ApplicationStatus.approved).toList();
  List<ApplicationEntity> get pendingApplications =>
      applications.where((x) => x.status == ApplicationStatus.pendingReview).toList();

  UserAccessRegistry({required this.applications, required this.memberships});
}
