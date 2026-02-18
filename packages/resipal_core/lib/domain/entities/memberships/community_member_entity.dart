import 'package:resipal_core/domain/refs/community_ref.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class MembershipEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final UserRef user;
  final CommunityRef community;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MembershipEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.user,
    required this.community,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });
}
