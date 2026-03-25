import 'dart:ui';

import 'package:flutter/material.dart';

enum PaymentStatus {
  approved,
  pendingReview,
  cancelled,
  unknown;

  static PaymentStatus fromString(String value) {
    return switch (value) {
      'approved' => PaymentStatus.approved,
      'pending_review' => PaymentStatus.pendingReview,
      'cancelled' => PaymentStatus.cancelled,
      _ => PaymentStatus.unknown,
    };
  }

  @override
  String toString() {
    return switch (this) {
      PaymentStatus.approved => 'approved',
      PaymentStatus.pendingReview => 'pending_review',
      PaymentStatus.cancelled => 'cancelled',
      PaymentStatus.unknown => 'unknown',
    };
  }

  Color color(ColorScheme colors) {
    return switch (this) {
      PaymentStatus.approved => colors.tertiary,
      PaymentStatus.pendingReview => Colors.orange.shade700,
      PaymentStatus.cancelled => colors.error,
      PaymentStatus.unknown => Colors.black,
    };
  }
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName => switch (this) {
    PaymentStatus.approved => 'Aprobado',
    PaymentStatus.pendingReview => 'En revisión',
    PaymentStatus.cancelled => 'Cancelado',
    PaymentStatus.unknown => 'Desconocido',
  };
}
