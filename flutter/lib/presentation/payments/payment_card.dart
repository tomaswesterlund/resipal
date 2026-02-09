import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class PaymentCard extends StatelessWidget {
  final PaymentEntity payment;

  const PaymentCard(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = AppColors.getColorForPayment(payment);
    final bool isApproved = payment.status == PaymentStatus.approved;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 6, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Reference & Status Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 20,
                                  color: AppColors.secondaryScale[400],
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: HeaderText.five(
                                    payment.reference ?? 'Sin referencia',
                                    color: AppColors.auxiliarScale[900]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isApproved
                                ? Icons.check_circle
                                : payment.status == PaymentStatus.pendingReview
                                ? Icons.pending_actions_rounded
                                : Icons.cancel_outlined,
                            color: statusColor,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        payment.note ?? 'Comprobante de pago adjunto',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: AppColors.auxiliarScale[500],
                          fontSize: 13,
                        ),
                      ),
                      const Divider(
                        height: 24,
                        thickness: 1,
                        color: Color(0xFFF4F5F4),
                      ),

                      // Footer: Status, Date & Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Left side: Date and Text Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha de pago: ${payment.date.toShortDate()}',
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.auxiliarScale[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  payment.status.displayName.toUpperCase(),
                                  style: GoogleFonts.raleway(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Right side: Amount
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Monto pagado',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.auxiliarScale[400],
                                ),
                              ),
                              AmountText.fromCents(
                                payment.amountInCents,
                                fontSize: 18,
                                color: isApproved
                                    ? AppColors.secondary
                                    : AppColors.auxiliarScale[800]!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
