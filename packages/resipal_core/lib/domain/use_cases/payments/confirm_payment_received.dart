import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';

class ConfirmPaymentReceived {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future call({required String communityId, required String userId, required String paymentId}) async {
    await _source.confirmPaymentReceived(communityId: communityId, userId: userId, paymentId: paymentId);
  }
}
