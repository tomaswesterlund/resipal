import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<UserModel>> watchUsers() {
    return _client
        .from('users')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((item) => UserModel.fromJson(item)).toList());
  }

  Stream<UserModel> watchUserById(String id) {
    return _client.from('users').stream(primaryKey: ['id']).eq('id', id)
    .map((data) {
      if (data.isEmpty) {
        throw Exception('User not found');
      }
      return UserModel.fromJson(data.first);
    });
  }

  Future<UserModel> getUserById(String id) async {
    final item = await _client.from('users').select().eq('id', id).single();
    final model = UserModel.fromJson(item);
    return model;
  }

  Future createUser({
    required String id,
    required String name,
    required String phoneNumber,
    required String emergencyPhoneNumber,
    required String email,
  }) async {
    await _client.rpc(
      'fn_create_user',
      params: {
        'p_user_id': id,
        'p_name': name,
        'p_phone_number': phoneNumber,
        'p_emergency_phone_number': emergencyPhoneNumber,
        'p_email': email,
      },
    );
  }
}
