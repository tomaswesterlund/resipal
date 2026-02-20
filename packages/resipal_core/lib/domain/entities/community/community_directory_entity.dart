import 'package:resipal_core/domain/entities/application_entity.dart';
import 'package:resipal_core/domain/entities/membership_entity.dart';
import 'package:resipal_core/domain/enums/community_application_status.dart';

class CommunityDirectoryEntity {
  final List<ApplicationEntity> applications;
  final List<MembershipEntity> members;

  CommunityDirectoryEntity(this.applications, this.members);

  // --- Membership Helpers ---
  bool get isEmpty => members.isEmpty;

  List<MembershipEntity> get admins => members.where((m) => m.isAdmin).toList();

  List<MembershipEntity> get securityStaff => members.where((m) => m.isSecurity).toList();

  List<MembershipEntity> get residents => members.where((m) => m.isResident).toList();

  // --- Application Helpers ---

  /// Used for the Admin "Solicitudes" badge
  List<ApplicationEntity> get pendingApplications =>
      applications.where((a) => a.status == ApplicationStatus.pendingReview).toList();

  List<ApplicationEntity> get rejectedApplications =>
      applications.where((a) => a.status == ApplicationStatus.revoked).toList();

  /// Total count of people attempting to join
  int get totalApplications => applications.length;

  /// Helper to find a specific application by user ID
  ApplicationEntity? findApplicationByUserId(String userId) =>
      applications.cast<ApplicationEntity?>().firstWhere((a) => a?.user.id == userId, orElse: () => null);
}
