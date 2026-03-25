import 'package:flutter/material.dart';

enum PropertyPaymentStatus {
  settled,
  due,
  overdue;

  static PropertyPaymentStatus fromString(String value) {
    return switch (value) {
      'settled' => PropertyPaymentStatus.settled,
      'due' => PropertyPaymentStatus.due,
      'overdue' => PropertyPaymentStatus.overdue,
      _ => throw UnimplementedError('Unknown PropertyPaymentStatus: $value'),
    };
  }

  @override
  String toString() {
    return switch (this) {
      PropertyPaymentStatus.settled => 'settled',
      PropertyPaymentStatus.due => 'due',
      PropertyPaymentStatus.overdue => 'overdue',
    };
  }

  /// Human-readable label for the UI
  String get display {
    return switch (this) {
      PropertyPaymentStatus.settled => 'Al día',
      PropertyPaymentStatus.due => 'Pago pendiente',
      PropertyPaymentStatus.overdue => 'Deuda vencida',
    };
  }

  /// Returns the semantic color for the UI indicators
  Color color(ColorScheme colors) {
    return switch (this) {
      PropertyPaymentStatus.settled => colors.tertiary, // Success Green
      PropertyPaymentStatus.due => Colors.orange.shade700, // Warning Amber
      PropertyPaymentStatus.overdue => colors.error, // Danger Red
    };
  }

  /// Optional: returns a specific icon for the status
  IconData get icon {
    return switch (this) {
      PropertyPaymentStatus.settled => Icons.check_circle_outline_rounded,
      PropertyPaymentStatus.due => Icons.warning,
      PropertyPaymentStatus.overdue => Icons.dangerous,
    };
  }
}
