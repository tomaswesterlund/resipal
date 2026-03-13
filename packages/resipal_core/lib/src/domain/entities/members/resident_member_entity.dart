import 'package:resipal_core/lib.dart';

class ResidentMemberEntity extends MemberEntity {
  final List<InvitationEntity> invitations;
  final List<VisitorEntity> visitors;

  ResidentMemberEntity({
    required super.name,
    required super.community,
    required super.user,
    required super.paymentLedger,
    required super.propertyRegistry,
    required super.isAdmin,
    required super.isResident,
    required super.isSecurity,
    required this.invitations,
    required this.visitors,
  });
}
