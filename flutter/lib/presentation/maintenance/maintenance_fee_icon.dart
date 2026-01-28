import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';

class MaintenanceFeeIcon extends StatelessWidget {
  final MaintenanceFeeEntity maintenanceFee;
  const MaintenanceFeeIcon(this.maintenanceFee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.getColorForMaintenanceFee(maintenanceFee).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.house_outlined,
        size: 48,
        color: AppColors.getColorForMaintenanceFee(maintenanceFee),
      ),
    );
  }
}
