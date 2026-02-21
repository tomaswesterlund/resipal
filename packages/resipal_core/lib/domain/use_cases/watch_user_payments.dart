import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payment_by_id.dart';

class WatchUserPayments {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Stream<List<PaymentEntity>> call(String userId) {
    return _source.watchByUserId(userId).map((models) {
      return models.map((model) => GetPaymentById().call(model.id)).toList();
    });
  }
}
