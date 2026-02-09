import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<PaymentModel>> watchPayments() {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((item) => PaymentModel.fromJson(item)).toList());
  }

  Stream<List<PaymentModel>> watchPaymentsByUserId(String userId) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) => data.map((item) => PaymentModel.fromJson(item)).toList());
  }

  Future registerNewPayment({
    required String userId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    await _client.rpc(
      'fn_register_new_payment',
      params: {
        'p_user_id': userId,
        'p_amount_in_cents': amountInCents,
        'p_date': date.toIso8601String(),
        'p_reference': reference,
        'p_note': note,
        'p_receipt_path': receiptPath,
      },
    );
  }

  Future approvePayment({required String userId, required String paymentId}) async {
    await _client.rpc('fn_approve_payment', params: {'p_user_id': userId, 'p_payment_id': paymentId});
  }
}
