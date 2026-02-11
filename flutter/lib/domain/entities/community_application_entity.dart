import 'package:resipal/domain/refs/community_ref.dart';
import 'package:resipal/domain/refs/user_ref.dart';

class CommunityApplicationEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final CommunityRef community;
  final UserRef user;
  final String? message;

  CommunityApplicationEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.community,
    required this.user,
    required this.message,
  });
}
