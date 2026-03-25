import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/data/models/user/upsert_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, UserModel> _cache = {};
  Map<String, UserModel> get cache => _cache;

  Stream<UserModel> watchById(String id) {
    return _client.from('users').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('User not found');
      }
      final model = UserModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  UserModel? getOptionalById(String id) => _cache[id];

  UserModel? getOptionalByEmail(String email) => _cache.values.where((x) => x.email.toLowerCase().trim() == email.toLowerCase().trim()).singleOrNull;

  bool userExistsInCache(String id) => _cache.containsKey(id);

  Future<bool> userExistsInDatabase(String id, {bool cacheExistingUser = true}) async {
    final item = await _client.from('users').select().eq('id', id).maybeSingle();

    // Cache
    if (cacheExistingUser && item != null) {
      final model = UserModel.fromMap(item);
      _cache[model.id] = model;
    }

    return item != null;
  }

  Future fetchAndCacheAll() async {
    final items = await _client.from('users').select();
    for (var item in items) {
      final model = UserModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('users').select().eq('id', id).single();
    final model = UserModel.fromMap(item);

    _cache[model.id] = model;
  }

  Future<UserId> upsert(UpsertUserModel model) async {
    final response = await _client.from('users').upsert(model.toMap()).select('id').single();
    return response['id'] as UserId;
  }

  Future updateFirebaseCloudMessagingToken({required String userId, required String fcmToken}) async {
    await _client.from('users').update({'fcm_token': fcmToken}).eq('id', userId);
  }
}
