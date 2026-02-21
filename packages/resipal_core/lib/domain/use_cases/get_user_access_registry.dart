import 'package:resipal_core/domain/entities/user_access_registry.dart';
import 'package:resipal_core/domain/use_cases/applications/get_applications_by_user.dart';
import 'package:resipal_core/domain/use_cases/memberships/get_memberships_by_community.dart';
import 'package:resipal_core/domain/use_cases/memberships/get_memberships_by_user.dart';

class GetUserAccessRegistry {
  UserAccessRegistry call(String userId) {
    final applications = GetApplicationsByUser().call(userId);
    final memberships = GetMembershipsByUser().call(userId);

    return UserAccessRegistry(applications: applications, memberships: memberships);
  }
}
