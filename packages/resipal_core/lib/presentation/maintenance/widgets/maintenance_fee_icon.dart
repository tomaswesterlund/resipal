import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/presentation/shared/colors/maintenance_colors.dart';

class MaintenanceFeeIcon extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  const MaintenanceFeeIcon(this.fee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MaintenanceColors.getColor(fee).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.house_outlined,
        size: 48,
        color: MaintenanceColors.getColor(fee),
      ),
    );
  }
}
