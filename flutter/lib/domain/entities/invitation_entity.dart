import 'package:resipal/domain/entities/refs/property_ref.dart';
import 'package:resipal/domain/entities/refs/user_ref.dart';
import 'package:resipal/domain/entities/refs/visitor_ref.dart';

class InvitationEntity {
  final String id;
  final UserRef user;
  final VisitorRef visitor;
  final PropertyRef property;
  final DateTime createdAt;
  final String qrCodeToken;
  final DateTime fromDate;
  final DateTime toDate;
  final int maxEntries;

  bool get isActive => true;

  InvitationEntity({
    required this.id,
    required this.user,
    required this.visitor,
    required this.property,
    required this.createdAt,
    required this.qrCodeToken,
    required this.fromDate,
    required this.toDate,
    required this.maxEntries,
  });
}
