import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<PropertyModel> getPropertyById(String id) async {
    final item = await _client.from('properties').select().eq('id', id).single();
    final model = PropertyModel.fromJson(item);
    return model;
  }

  Future<List<PropertyModel>> getPropertiesByUserId(String userId) async {
    final items = await _client.from('properties').select().eq('user_id', userId);
    final models = items.map((i) => PropertyModel.fromJson(i)).toList();
    return models;
  }
}