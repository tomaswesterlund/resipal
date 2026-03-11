import 'package:flutter/material.dart';

enum ApplicationStatus {
  approved,
  invited,
  pendingApproval,
  rejected,
  revoked;

  static ApplicationStatus fromString(String value) {
    return switch (value) {
      'approved' => ApplicationStatus.approved,
      'invited' => ApplicationStatus.invited,
      'pending_approval' => ApplicationStatus.pendingApproval,
      'rejected' => ApplicationStatus.rejected,
      'revoked' => ApplicationStatus.revoked,
      _ => throw UnimplementedError('Unknown ApplicationStatus: $value'),
    };
  }

  @override
  String toString() {
    return switch (this) {
      ApplicationStatus.approved => 'approved',
      ApplicationStatus.invited => 'invited',
      ApplicationStatus.pendingApproval => 'pending_approval',
      ApplicationStatus.rejected => 'rejected',
      ApplicationStatus.revoked => 'revoked',
    };
  }

  /// Human-readable label for the UI
  String get display {
    return switch (this) {
      ApplicationStatus.approved => 'Aprobado',
      ApplicationStatus.invited => 'Invitado',
      ApplicationStatus.pendingApproval => 'Pendiente',
      ApplicationStatus.rejected => 'Rechazado',
      ApplicationStatus.revoked => 'Revocado',
    };
  }

  /// Returns the semantic color for badges/indicators
  Color color(ColorScheme colors) {
    return switch (this) {
      ApplicationStatus.approved => colors.tertiary,       // Success Green
      ApplicationStatus.invited => colors.primary,        // Resipal Blue/Green
      ApplicationStatus.pendingApproval => colors.secondary, // Warning Amber
      ApplicationStatus.rejected => colors.error,         // Danger Red
      ApplicationStatus.revoked => colors.outline,       // Neutral Grey
    };
  }
}