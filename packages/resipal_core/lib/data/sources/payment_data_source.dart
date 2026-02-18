import 'package:get_it/get_it.dart';
import '../models/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, PaymentModel> _cache = {};

  Stream<List<PaymentModel>> watchByUserId(String userId) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map(
          (data) => data.map((item) {
            final model = PaymentModel.fromJson(item);
            _cache[model.id] = model; // Update cache
            return model;
          }).toList(),
        );
  }

  Stream<List<PaymentModel>> watchByCommunityId(String communityId) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = PaymentModel.fromJson(item);
            _cache[model.id] = model; // Update cache
            return model;
          }).toList(),
        );
  }

  PaymentModel getById(String id) => _cache[id]!;

  List<PaymentModel> getByCommunityId(String communityId) => _cache.values.where((m) => m.communityId == communityId).toList();

  List<PaymentModel> getByUserId(String userId) => _cache.values.where((m) => m.userId == userId).toList();

  Future registerPayment({
    required String communityId,
    required String userId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    await _client.rpc(
      'fn_register_payment',
      params: {
        'p_community_id': communityId,
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
