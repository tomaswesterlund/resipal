import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payment_by_id.dart';

class FetchPaymentById {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future<PaymentEntity> call(String id) async {
    final model = await _source.fetchAndCacheById(id);
    final entity = GetPaymentById().call(model.id);
    return entity;
  }
}
