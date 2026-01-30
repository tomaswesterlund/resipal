import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<PropertyModel>> watchProperties() {
    return _client.from('properties').stream(primaryKey: ['id']).map((data) => data.map((item) => PropertyModel.fromJson(item)).toList());
  }
}
