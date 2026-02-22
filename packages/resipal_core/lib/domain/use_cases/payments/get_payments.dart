import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payment_by_id.dart';

class GetPayments {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();
  final GetPaymentById _getPayment = GetPaymentById();

  List<PaymentEntity> byCommunityId(String userId) {
    final models = _source.getByCommunityId(userId);
    final payments = models.map((m) => _getPayment.call(m.id)).toList();
    return payments;
  }

  List<PaymentEntity> byUserId(String userId) {
    final models = _source.getByUserId(userId);
    final payments = models.map((m) => _getPayment.call(m.id)).toList();
    return payments;
  }

  List<PaymentEntity> byCommunityAndUserId({required String communityId, required String userId}) {
    final models = _source.getByCommunityAndUserId(communityId: communityId, userId: userId);
    final payments = models.map((m) => _getPayment.call(m.id)).toList();
    return payments;
  }
}
