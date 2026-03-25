import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

class AccessRegistry extends Equatable {
  final List<InvitationEntity> invitations;
  final List<VisitorEntity> visitors;

  const AccessRegistry({
    required this.invitations,
    required this.visitors,
  });

  // --- Filtering Logic ---

  /// Returns all invitations that are currently usable (not expired/limit reached).
  List<InvitationEntity> get activeInvitations =>
      invitations.where((i) => i.isActive).toList();

  // --- Search & Validation Logic ---

  // /// Finds a specific invitation by its QR token.
  // InvitationEntity? findByToken(String token) {
  //   try {
  //     return invitations.firstWhere((i) => i.qrCodeToken == token);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // /// Finds the full Visitor profile associated with a specific invitation.
  // VisitorEntity? getVisitorForInvitation(InvitationEntity invitation) {
  //   try {
  //     return visitors.firstWhere((v) => v.id == invitation.visitor.id);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // --- Statistical Logic (Business Logic in Flutter) ---

  // /// Gets the total number of entries recorded across all tracked invitations.
  // int get totalEntryCount =>
  //     invitations.fold(0, (sum, i) => sum + i.usageCount);

  // /// Identifies "High Traffic" visitors (e.g., more than 5 entries this month).
  // List<VisitorEntity> get frequentVisitors {
  //   final visitorIds = invitations
  //       .where((i) => i.usageCount > 5)
  //       .map((i) => i.visitor.id)
  //       .toSet();

  //   return visitors.where((v) => visitorIds.contains(v.id)).toList();
  // }


  @override
  List<Object?> get props => [invitations, visitors];
}