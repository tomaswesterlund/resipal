import 'package:resipal_core/domain/entities/user_access_registry.dart';
import 'package:resipal_core/domain/use_cases/get_user_community_applications.dart';
import 'package:resipal_core/domain/use_cases/get_user_community_memberships.dart';

class GetUserAccessRegistry {
  UserAccessRegistry call(String userId) {
    final applications = GetUserCommunityApplications().call(userId);
    final memberships = GetUserCommunityMemberships().call(userId);

    return UserAccessRegistry(applications: applications, memberships: memberships);
  }
}
