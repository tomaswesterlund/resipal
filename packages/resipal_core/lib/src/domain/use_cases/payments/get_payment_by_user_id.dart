import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payment_by_id.dart';

class GetPaymentByUserId {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();
  final GetPaymentById _getPayment = GetPaymentById();

  List<PaymentEntity> call({required String userId}) {
    final models = _source.getByUserId(userId);
    final payments = models.map((m) => _getPayment.call(m.id)).toList();
    return payments;
  }

}
