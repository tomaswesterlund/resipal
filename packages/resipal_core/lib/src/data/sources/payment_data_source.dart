import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/payment/upsert_payment_model.dart';
import '../models/payment/payment_model.dart';
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

  Future<PaymentId> upsert(UpsertPaymentModel model) async {
    final response = await _client.from('payments').upsert(model.toMap()).select('id').single();
    return response['id'] as PaymentId;
  }

  Future<void> updateStatus({required String id, required String status}) async {
    // 1. Update the remote database
    await _client
        .from('payments')
        .update({'status': status}) // Assumes your DB uses the string names (e.g., 'confirmed')
        .eq('id', id);

    // 2. Update the local cache if the record exists
    if (_cache.containsKey(id)) {
      _cache[id] = _cache[id]!.copyWith(status: status);
    }
  }
}
