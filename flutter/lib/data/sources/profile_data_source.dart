import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<List<ProfileModel>> getProfiles() async {
    final items = await _client.from('profiles').select();
    final models = items.map((i) => ProfileModel.fromJson(i)).toList();
    return models;
  }

  Future<ProfileModel> getProfileById(String id) async {
    final item = await _client.from('profiles').select().eq('id', id).single();
    final model = ProfileModel.fromJson(item);
    return model;
  }
}