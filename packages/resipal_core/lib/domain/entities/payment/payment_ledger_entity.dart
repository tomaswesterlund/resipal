import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/enums/payment_status.dart';

class PaymentLedgerEntity {
  List<PaymentEntity> payments;

  PaymentLedgerEntity(this.payments);

  List<PaymentEntity> get pendingPayments =>
      payments.where((p) => p.status == PaymentStatus.pendingReview).toList();

  int get pendingPaymentAmountInCents {
    final pendingAmountInCents = pendingPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return pendingAmountInCents;
  }

  int get totalBalanceInCents {
    final approvedAndPaidPayments = payments.where(
      (p) => p.status == PaymentStatus.approved,
    );
    final approvedPaymentAmountInCents = approvedAndPaidPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return approvedPaymentAmountInCents;
  }
}
