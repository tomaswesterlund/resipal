import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/movement_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MovementDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<MovementModel>> watchMovementsByUserId(String userId) {
    return _client
        .from('movements')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map(
          (data) => data.map((json) => MovementModel.fromJson(json)).toList(),
        );
  }

  Future<List<MovementModel>> getMovements() async {
    final items = await _client.from('movements').select();
    final models = items.map((i) => MovementModel.fromJson(i)).toList();
    return models;
  }

  Future<List<MovementModel>> getMovementsByUserId(String userId) async {
    return getMovements();
  }
}
