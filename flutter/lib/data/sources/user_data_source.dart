import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, UserModel> _cache = {};

  Stream<UserModel> watchById(String id) {
    return _client.from('users').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('User not found');
      }
      final model = UserModel.fromJson(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  UserModel getById(String id) => _cache[id]!;

  Future<UserModel> fetchById(String id) async {
    final item = await _client.from('users').select().eq('id', id).single();
    final model = UserModel.fromJson(item);

    _cache[model.id] = model; // Update cache
    return model;
  }

  Future createUser({
    required String userId,
    required String name,
    required String phoneNumber,
    required String emergencyPhoneNumber,
    required String email,
  }) async {
    await _client.rpc(
      'fn_create_user',
      params: {
        'p_user_id': userId,
        'p_name': name,
        'p_phone_number': phoneNumber,
        'p_emergency_phone_number': emergencyPhoneNumber,
        'p_email': email,
      },
    );
    // Note: The watchById stream for this user ID will automatically
    // update the cache once the record is created in Supabase.
  }
}
