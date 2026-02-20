import 'package:resipal_core/domain/entities/resident_entity.dart';
import 'package:resipal_core/domain/refs/community_ref.dart';

class MembershipEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final ResidentEntity resident;
  final CommunityRef community;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MembershipEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.resident,
    required this.community,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });
}
