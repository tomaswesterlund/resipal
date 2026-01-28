import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';
import 'package:resipal/presentation/movements/pages/maintenance_fee_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class MaintenanceFeeMovementTile extends StatelessWidget {
  final MovementEntity movement;

  const MaintenanceFeeMovementTile(this.movement, {super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming movement.data holds the MaintenanceFeeEntity
    final fee = movement.data as MaintenanceFeeEntity;
    final statusData = _getStatusDisplayData(fee.status);

    return GestureDetector(
      onTap: () => Go.to(MaintenanceFeeDetailsPage(fee)),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Icon container: Using home_work for maintenance/property vibes
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusData.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.home_work_rounded,
                  size: 28,
                  color: statusData.color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText.five(
                      fee.note?.isNotEmpty == true
                          ? fee.note!
                          : 'Cuota de Mantenimiento',
                    ),
                    HeaderText.six(
                      'Periodo: ${fee.fromDate.toShortDate()} - ${fee.toDate.toShortDate()}',
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountText.fromCents(
                    fee.amountInCents,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 4),
                  // Dynamic Status Badge (Paid / Pending)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusData.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      statusData.label.toUpperCase(),
                      style: TextStyle(
                        color: statusData.color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  _FeeStatusDisplay _getStatusDisplayData(MaintenanceFeeStatus status) {
    return switch (status) {
      MaintenanceFeeStatus.paid => const _FeeStatusDisplay(
        label: 'Pagado',
        color: Color(0xFF2E7D32), // Success Green
      ),
      MaintenanceFeeStatus.pending => const _FeeStatusDisplay(
        label: 'Pendiente',
        color: Colors.orange,
      ),
      MaintenanceFeeStatus.overdue => const _FeeStatusDisplay(
        label: 'Vencido',
        color: Colors.redAccent, // Alert Red
      ),
      MaintenanceFeeStatus.upcoming => const _FeeStatusDisplay(
        label: 'Próximo',
        color: Colors.blueGrey, // Neutral Blue/Grey
      ),
    };
  }
}

class _FeeStatusDisplay {
  final String label;
  final Color color;
  const _FeeStatusDisplay({required this.label, required this.color});
}
