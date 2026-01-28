import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<PaymentModel> watchPaymentById(String id) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((data) => PaymentModel.fromJson(data.first));
  }

  Future<PaymentModel> getPaymentById(String id) async {
    final item = await _client.from('payments').select().eq('id', id).single();
    final model = PaymentModel.fromJson(item);
    return model;
  }

  Future<List<PaymentModel>> getPaymentsByUserId(String userId) async {
    final items = await _client.from('payments').select().eq('user_id', userId);
    final models = items.map((i) => PaymentModel.fromJson(i)).toList();
    return models;
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

  Future approvePayment({
    required String userId,
    required String paymentId,
  }) async {
    await _client.rpc(
      'fn_approve_payment',
      params: {'p_user_id': userId, 'p_payment_id': paymentId},
    );
  }
}
