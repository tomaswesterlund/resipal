import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';

class ApprovePayment {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future call({required String userId, required String paymentId}) async {
    await _source.approvePayment(userId: userId, paymentId: paymentId);
  }
}
