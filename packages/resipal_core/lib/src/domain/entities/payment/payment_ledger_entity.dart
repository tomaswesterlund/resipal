import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/enums/payment_status.dart';

class PaymentLedgerEntity {
  List<PaymentEntity> payments;

  PaymentLedgerEntity(this.payments);

  List<PaymentEntity> get pendingPayments => payments.where((p) => p.status == PaymentStatus.pendingReview).toList();

  int get pendingPaymentAmountInCents {
    final pendingAmountInCents = pendingPayments.fold(0, (sum, payment) => sum = sum + payment.amountInCents);
    return pendingAmountInCents;
  }

  int get totalPaymentBalanceInCents {
    final approvedAndPaidPayments = payments.where((p) => p.status == PaymentStatus.approved);
    final approvedPaymentAmountInCents = approvedAndPaidPayments.fold(
      0,
      (sum, payment) => sum = sum + payment.amountInCents,
    );
    return approvedPaymentAmountInCents;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'payments': payments.map((p) => p.toMap()).toList()};
  }
}
