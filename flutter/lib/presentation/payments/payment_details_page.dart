import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/images/receipt_preview.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class PaymentDetailsPage extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentDetailsPage(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusDisplayData(payment.status);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Detalle de Pago'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Amount Card
            _buildHeroCard(statusData),
            const SizedBox(height: 20),

            if (payment.receiptPath != null &&
                payment.receiptPath!.isNotEmpty) ...[
              const _SectionLabel(label: 'COMPROBANTE ADJUNTO'),
              ReceiptPreview(receiptPath: payment.receiptPath!),
              const SizedBox(height: 20),
            ],

            // General Information
            const _SectionLabel(label: 'INFORMACIÓN GENERAL'),
            _buildDetailsCard(),
            const SizedBox(height: 20),

            // Notes Section
            if (payment.note != null && payment.note!.isNotEmpty) ...[
              const _SectionLabel(label: 'NOTA / CONCEPTO'),
              _buildNoteCard(),
              const SizedBox(height: 20),
            ],

            // Helpful tip for the user
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(_StatusDisplay statusData) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusData.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 40,
                color: statusData.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              CurrencyFormatter.fromCents(payment.amountInCents),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: statusData.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusData.label.toUpperCase(),
                style: TextStyle(
                  color: statusData.color,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildDetailTile(
            icon: Icons.event_available_rounded,
            label: 'Fecha de pago',
            value: payment.date.toShortDate(),
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.upload_file_rounded,
            label: 'Fecha de registro (en Resipal)',
            value: payment.createdAt.toShortDate(),
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.tag,
            label: 'Referencia',
            value: payment.reference?.isNotEmpty == true
                ? payment.reference!
                : 'Sin referencia',
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.info_outline,
            label: 'ID de registro',
            value: '#${payment.id.split('-').first.toUpperCase()}',
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          payment.note!,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Este pago fue registrado el ${_formatFullDate(payment.createdAt)}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  String _formatFullDate(DateTime date) {
    // Simple helper if you don't have a specific formatter for full text
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800], size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  _StatusDisplay _getStatusDisplayData(PaymentStatus status) {
    return switch (status) {
      PaymentStatus.approved => const _StatusDisplay(
        label: 'Aprobado',
        color: Colors.green,
      ),
      PaymentStatus.pendingReview => const _StatusDisplay(
        label: 'Pendiente de Revisión',
        color: Colors.orange,
      ),
      PaymentStatus.cancelled => const _StatusDisplay(
        label: 'Cancelado',
        color: Colors.red,
      ),
      _ => const _StatusDisplay(label: 'Desconocido', color: Colors.grey),
    };
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _StatusDisplay {
  final String label;
  final Color color;
  const _StatusDisplay({required this.label, required this.color});
}
