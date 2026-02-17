import 'dart:ui';
import 'package:resipal_core/domain/entities/payment_entity.dart';
import 'package:resipal_core/domain/enums/payment_status.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';

class PaymentColors {
  static Color getColor(PaymentEntity payment) {
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
}
