import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payment_by_id.dart';

class WatchPaymentById {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();
  Stream<PaymentEntity> call(String id) {
    return _source.watchById(id).map((x) => GetPaymentById().call(id));
  }
}
