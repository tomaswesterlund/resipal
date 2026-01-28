import 'package:flutter/material.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class AppColors {
  static const Color primary = Color(0xFF1A4644);
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Colors.white;

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF97316);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF64748B);

  static Color getColorForPayment(PaymentEntity payment) {
    switch (payment.status) {
      case PaymentStatus.approved:
        return AppColors.success;
      case PaymentStatus.pendingReview:
        return AppColors.warning;
      case PaymentStatus.cancelled:
        return AppColors.danger;
      case PaymentStatus.unknown:
        return AppColors.info;
    }
  }

  static Color getColorForMaintenanceFee(MaintenanceFeeEntity maintenance) {
    switch (maintenance.status) {
      case MaintenanceFeeStatus.paid:
        return AppColors.success;
      case MaintenanceFeeStatus.pending:
        return AppColors.warning;
      case MaintenanceFeeStatus.overdue:
        return AppColors.danger;
      case MaintenanceFeeStatus.upcoming:
        return AppColors.info;
    }
  }
}
