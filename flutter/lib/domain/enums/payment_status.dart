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
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName => switch (this) {
    PaymentStatus.approved => 'Aprobado',
    PaymentStatus.pendingReview => 'En revisión',
    PaymentStatus.cancelled => 'Cancelado',
    PaymentStatus.unknown => 'Desconocido',
  };
}
