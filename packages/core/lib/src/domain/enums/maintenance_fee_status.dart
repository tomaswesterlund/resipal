import 'dart:ui';

import 'package:flutter/material.dart';

enum MaintenanceFeeStatus {
  paid,
  pending,
  overdue,
  upcoming;

  Color color(ColorScheme colors) {
    return switch (this) {
      MaintenanceFeeStatus.paid => colors.tertiary,
      MaintenanceFeeStatus.pending => Colors.orange.shade700,
      MaintenanceFeeStatus.overdue => colors.error,
      MaintenanceFeeStatus.upcoming => Colors.black,
    };
  }

  String get display {
    return switch (this) {
      MaintenanceFeeStatus.paid => 'Pagado',
      MaintenanceFeeStatus.pending => 'Pendiente',
      MaintenanceFeeStatus.overdue => 'Vencido',
      MaintenanceFeeStatus.upcoming => 'Próximo'
    };
  }
}
