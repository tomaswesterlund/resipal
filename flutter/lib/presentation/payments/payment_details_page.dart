import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/images/receipt_preview.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_header/payment_header.dart';

class PaymentDetailsPage extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentDetailsPage(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(title: 'Detalle de Pago'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaymentHeader(paymentId: payment.id),
            const SizedBox(height: 32),

            if (payment.receiptPath != null &&
                payment.receiptPath!.isNotEmpty) ...[
              SectionHeaderText(text: 'COMPROBANTE ADJUNTO'),
              ReceiptPreview(receiptPath: payment.receiptPath!),
              const SizedBox(height: 20),
            ],

            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.event_available_rounded,
                    label: 'Fecha de pago',
                    value: payment.date.toShortDate(),
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.upload_file_rounded,
                    label: 'Fecha de registro (en Resipal)',
                    value: payment.createdAt.toShortDate(),
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.tag,
                    label: 'Referencia',
                    value: payment.reference?.isNotEmpty == true
                        ? payment.reference!
                        : 'Sin referencia',
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.info_outline,
                    label: 'ID de registro',
                    value: '#${payment.id.split('-').first.toUpperCase()}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Notes Section
            if (payment.note != null && payment.note!.isNotEmpty) ...[
              const SectionHeaderText(text: 'NOTA / CONCEPTO'),
              DefaultCard(
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
              ),
              
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
