import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<List<UserModel>> getUsers() async {
    final items = await _client.from('users').select();
    final models = items.map((i) => UserModel.fromJson(i)).toList();
    return models;
  }

  Future<UserModel> getUserById(String id) async {
    final item = await _client.from('users').select().eq('id', id).single();
    final model = UserModel.fromJson(item);
    return model;
  }
}