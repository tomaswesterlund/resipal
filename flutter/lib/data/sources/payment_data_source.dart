import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  
  Future<List<PaymentModel>> getPaymentsByUserId(String userId) async {
    final items = await _client.from('payments').select().eq('user_id', userId);
    final models = items.map((i) => PaymentModel.fromJson(i)).toList();
    return models;
  }
}