import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payment_by_id.dart';

class WatchPaymentsByCommunity {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();
  final GetPaymentById _getPayment = GetPaymentById();

  Stream<List<PaymentEntity>> call(String communityId) {
    return _source.watchByCommunityId(communityId).map((models) {
      final entities = models.map((x) => _getPayment(x.id)).toList();
      return entities;
    });
  }
}
