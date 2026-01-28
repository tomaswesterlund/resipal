import 'package:flutter/widgets.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';

class MaintenanceStatusPill extends StatelessWidget {
  final MaintenanceFeeEntity maintenanceFee;
  const MaintenanceStatusPill(this.maintenanceFee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.getColorForMaintenanceFee(maintenanceFee).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getLabel().toUpperCase(),
        style: TextStyle(
          color: AppColors.getColorForMaintenanceFee(maintenanceFee),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          fontSize: 12,
        ),
      ),
    );
  }

  String _getLabel() {
    switch (maintenanceFee.status) {
      case MaintenanceFeeStatus.paid:
        return 'Pagado';
      case MaintenanceFeeStatus.pending:
        return 'Pendiente';
      case MaintenanceFeeStatus.overdue:
        return 'Vencido';
      case MaintenanceFeeStatus.upcoming:
        return 'Próximo';
    }
  }
}
