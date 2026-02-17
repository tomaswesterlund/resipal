import 'package:resipal_core/domain/entities/community_application_entity.dart';
import 'package:resipal_core/domain/enums/community_application_status.dart';

class UserMembership {
  final List<CommunityApplicationEntity> applications;

  List<CommunityApplicationEntity> get approvedApplications => applications
      .where((x) => x.status == CommunityApplicationStatus.approved)
      .toList();

  List<CommunityApplicationEntity> get pendingApplications => applications
      .where((x) => x.status == CommunityApplicationStatus.pendingReview)
      .toList();

  CommunityApplicationEntity get defaultApprovedApplication {
    if (approvedApplications.isEmpty) {
      throw Exception('approvedApplications.isEmpty');
    }

    if (approvedApplications.length > 1) {
      throw Exception('approvedApplications.length > 1');
    }

    return approvedApplications.first;
  }

  UserMembership({required this.applications});
}
