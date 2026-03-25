import 'package:flutter/material.dart';

enum InvitationStatus {
  expired,
  upcoming,
  active,
  limitReached; // New state

  Color color(ColorScheme colors) {
    return switch (this) {
      InvitationStatus.active => colors.tertiary,
      InvitationStatus.expired => colors.error,
      InvitationStatus.upcoming => Colors.orange.shade700,
      InvitationStatus.limitReached => colors.error, // Red like expired
    };
  }

  String get display {
    return switch (this) {
      InvitationStatus.active => 'Activa',
      InvitationStatus.expired => 'Expirada',
      InvitationStatus.upcoming => 'Próxima',
      InvitationStatus.limitReached => 'Límite Alcanzado',
    };
  }

  IconData get icon {
    return switch (this) {
      InvitationStatus.active => Icons.check_circle_outline_rounded,
      InvitationStatus.expired => Icons.block_rounded,
      InvitationStatus.upcoming => Icons.schedule_rounded,
      InvitationStatus.limitReached => Icons.no_accounts_rounded, // Specific icon for "no more entries"
    };
  }
}
