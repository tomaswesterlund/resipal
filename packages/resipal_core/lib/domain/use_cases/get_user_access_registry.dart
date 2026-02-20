import 'package:resipal_core/domain/entities/user_access_registry.dart';
import 'package:resipal_core/domain/use_cases/get_applications.dart';
import 'package:resipal_core/domain/use_cases/get_memberships.dart';

class GetUserAccessRegistry {
  UserAccessRegistry call(String userId) {
    final applications = GetApplications().byUserId(userId);
    final memberships = GetMemberships().byUserId(userId);

    return UserAccessRegistry(applications: applications, memberships: memberships);
  }
}
