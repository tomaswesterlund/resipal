import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/use_cases/get_payment.dart';

class GetUserPayments {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  List<PaymentEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    final payments = models.map((m) => GetPayment().call(m.id)).toList();
    return payments;
  }
}
