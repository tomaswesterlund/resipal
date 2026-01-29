import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/visitor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<List<VisitorModel>> getVisitors() async {
    final items = await _client.from('visitors').select();
    final models = items.map((i) => VisitorModel.fromJson(i)).toList();
    return models;
  }

  Future<VisitorModel> getVisitorById(String id) async {
    final item = await _client.from('visitors').select().eq('id', id).single();
    final model = VisitorModel.fromJson(item);
    return model;
  }

  Future<List<VisitorModel>> getVisitorsByUserId(String userId) async {
    final items = await _client.from('visitors').select().eq('user_id', userId);
    final models = items.map((i) => VisitorModel.fromJson(i)).toList();
    return models;
  }
}
