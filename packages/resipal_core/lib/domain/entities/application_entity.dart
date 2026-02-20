import 'package:resipal_core/domain/enums/community_application_status.dart';
import 'package:resipal_core/domain/refs/community_ref.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class ApplicationEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final CommunityRef community;
  final UserRef user;
  final ApplicationStatus status;
  final String? message;

  ApplicationEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.community,
    required this.user,
    required this.status,
    required this.message,
  });
}
