import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment_entity.dart';
import 'package:resipal_core/domain/use_cases/get_payment.dart';

class GetCommunityPayments {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  List<PaymentEntity> call(String communityId) {
    final models = _source.getByCommunityId(communityId);
    final list = models.map((m) => GetPayment().call(m.id)).toList();
    return list;
  }
}
