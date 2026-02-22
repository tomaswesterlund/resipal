import 'package:get_it/get_it.dart';
import '../models/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, PaymentModel> _cache = {};

  Stream<PaymentModel> watchById(String id) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map(
          (data) => data
              .map((item) {
                final model = PaymentModel.fromMap(item);
                _cache[model.id] = model;
                return model;
              })
              .toList()
              .first,
        );
  }

  Stream<List<PaymentModel>> watchByUserId(String userId) {
    return _client
        .from('payments')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map(
          (data) => data.map((item) {
            final model = PaymentModel.fromMap(item);
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
            final model = PaymentModel.fromMap(item);
            _cache[model.id] = model; // Update cache
            return model;
          }).toList(),
        );
  }

  PaymentModel getById(String id) => _cache[id]!;

  List<PaymentModel> getByCommunityId(String communityId) =>
      _cache.values.where((m) => m.communityId == communityId).toList();

  List<PaymentModel> getByUserId(String userId) => _cache.values.where((m) => m.userId == userId).toList();

  List<PaymentModel> getByCommunityAndUserId({required String communityId, required String userId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.userId == userId).toList();

  Future<PaymentModel> fetchAndCacheById(String id) async {
    final item = await _client.from('payments').select().eq('id', id).single();
    final model = PaymentModel.fromMap(item);
    _cache[model.id] = model;
    return model;
  }

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

  Future confirmPaymentReceived({
    required String communityId,
    required String userId,
    required String paymentId,
  }) async {
    await _client.rpc(
      'fn_confirm_payment_received',
      params: {'p_community_id': communityId, 'p_user_id': userId, 'p_payment_id': paymentId},
    );
  }
}
