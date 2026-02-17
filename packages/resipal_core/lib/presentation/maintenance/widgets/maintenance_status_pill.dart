import 'package:flutter/widgets.dart';
import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/domain/enums/maintenance_fee_status.dart';
import 'package:resipal_core/presentation/shared/colors/maintenance_colors.dart';

class MaintenanceStatusPill extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  const MaintenanceStatusPill(this.fee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: MaintenanceColors.getColor(fee).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getLabel().toUpperCase(),
        style: TextStyle(
          color: MaintenanceColors.getColor(fee),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          fontSize: 12,
        ),
      ),
    );
  }

  String _getLabel() {
    switch (fee.status) {
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
