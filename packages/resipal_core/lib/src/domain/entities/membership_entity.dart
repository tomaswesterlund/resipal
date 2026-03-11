import 'package:resipal_core/lib.dart';

class MembershipEntity {
  final String id;
  final CommunityRef community;
  final UserRef user;
  final DateTime createdAt;
  final String createdBy;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MembershipEntity({
    required this.id,
    required this.community,
    required this.user,
    required this.createdAt,
    required this.createdBy,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });
}
