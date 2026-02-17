import 'package:get_it/get_it.dart';
import '../models/movement_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MovementDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<MovementModel>> watchMovements() {
    return _client
        .from('movements')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.map((json) => MovementModel.fromJson(json)).toList(),
        );
  }
}
