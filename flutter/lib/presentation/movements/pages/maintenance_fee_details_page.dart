import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';

class MaintenanceFeeDetailsPage extends StatelessWidget {
  final MaintenanceFeeEntity maintenanceFee;
  const MaintenanceFeeDetailsPage(this.maintenanceFee, {super.key});

  @override
  Widget build(BuildContext context) {
    final status = maintenanceFee.status;
    final statusColor = _getStatusColor(status);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: HeaderText.four('Detalle de Cuota'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- Status Badge and Amount Header ---
            _buildHeader(status, statusColor),
            const SizedBox(height: 24),

            // --- Details Card ---
            _buildMainDetailsCard(),
            const SizedBox(height: 16),

            // --- Date Breakdown Section ---
            _buildDateSection(),
            
            const SizedBox(height: 32),
            
            // --- Action Button (Only if not paid) ---
            if (!maintenanceFee.isPaid)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Logic to link a payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A4644),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: HeaderText.five('REGISTRAR PAGO', color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(MaintenanceFeeStatus status, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(status == MaintenanceFeeStatus.overdue ? Icons.warning_rounded : Icons.info_outline, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                _getStatusLabel(status).toUpperCase(),
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AmountText.fromCents(
          maintenanceFee.amountInCents,
          fontSize: 40,
        ),
        BodyText.small('Monto Total de la Cuota', color: Colors.grey),
      ],
    );
  }

  Widget _buildMainDetailsCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _DetailRow(
              label: 'Contrato',
              value: maintenanceFee.contract.name,
              icon: Icons.assignment_outlined,
            ),
            const Divider(height: 32),
            _DetailRow(
              label: 'Periodo',
              value: '${maintenanceFee.fromDate.toShortDate()} al ${maintenanceFee.toDate.toShortDate()}',
              icon: Icons.calendar_today_outlined,
            ),
            if (maintenanceFee.note != null) ...[
              const Divider(height: 32),
              _DetailRow(
                label: 'Nota',
                value: maintenanceFee.note!,
                icon: Icons.notes_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: HeaderText.six('CRONOLOGÍA', color: Colors.grey),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _DateStep(
                  label: 'Fecha de Emisión',
                  date: maintenanceFee.createdAt,
                  isDone: true,
                ),
                _DateStep(
                  label: 'Fecha Vencimiento',
                  date: maintenanceFee.dueDate,
                  isDone: false,
                  isAlert: maintenanceFee.status == MaintenanceFeeStatus.overdue,
                ),
                if (maintenanceFee.isPaid)
                  _DateStep(
                    label: 'Fecha de Pago',
                    date: maintenanceFee.paymentDate!,
                    isDone: true,
                    isSuccess: true,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Helpers ---

  Color _getStatusColor(MaintenanceFeeStatus status) {
    return switch (status) {
      MaintenanceFeeStatus.paid => const Color(0xFF2E7D32),
      MaintenanceFeeStatus.overdue => const Color(0xFFD32F2F),
      MaintenanceFeeStatus.pending => Colors.orange,
      MaintenanceFeeStatus.upcoming => Colors.blueGrey,
    };
  }

  String _getStatusLabel(MaintenanceFeeStatus status) {
    return switch (status) {
      MaintenanceFeeStatus.paid => 'Pagado',
      MaintenanceFeeStatus.overdue => 'Vencido / Urgente',
      MaintenanceFeeStatus.pending => 'Pendiente de Pago',
      MaintenanceFeeStatus.upcoming => 'Próximo Mes',
    };
  }
}

// Internal Helper Widgets
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        BodyText.small(label, color: Colors.grey),
        const Spacer(),
        HeaderText.six(value),
      ],
    );
  }
}

class _DateStep extends StatelessWidget {
  final String label;
  final DateTime date;
  final bool isDone;
  final bool isAlert;
  final bool isSuccess;

  const _DateStep({
    required this.label,
    required this.date,
    this.isDone = false,
    this.isAlert = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isAlert ? Colors.red : (isSuccess ? Colors.green : Colors.black87);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : (isAlert ? Icons.error : Icons.circle),
            size: 14,
            color: color.withOpacity(0.5),
          ),
          const SizedBox(width: 12),
          BodyText.small(label),
          const Spacer(),
          BodyText.small(date.toShortDate(), fontWeight: FontWeight.bold, color: color),
        ],
      ),
    );
  }
}