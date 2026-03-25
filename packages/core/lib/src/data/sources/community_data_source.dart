import 'package:get_it/get_it.dart';
import 'package:core/src/data/models/community/upsert_community_model.dart';
import 'package:core/src/domain/typedefs.dart';
import '../models/community/community_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, CommunityModel> _cache = {};

  Stream<List<CommunityModel>> watchAll() {
    return _client
        .from('communities')
        .stream(primaryKey: ['id'])
        .map(
          (data) => data.map((item) {
            final model = CommunityModel.fromMap(item);
            _cache[model.id] = model; // Update cache
            return model;
          }).toList(),
        );
  }

  Stream<CommunityModel> watchById(String id) {
    return _client.from('communities').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('Community not found');
      }

      final model = CommunityModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  List<CommunityModel> getAll() => _cache.values.toList();

  CommunityModel? getById(String id) => _cache[id];

  Future fetchAndCacheAll() async {
    final items = await _client.from('communities').select();
    for (var item in items) {
      final model = CommunityModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('communities').select().eq('id', id).single();
    final model = CommunityModel.fromMap(item);

    _cache[model.id] = model;
  }

  Future<CommunityId> upsert(UpsertCommunityModel model) async {
    final response = await _client.from('communities').upsert(model.toMap()).select('id').single();
    return response['id'] as UserId;
  }

  Future joinCommunity({required String userId, required String communityId}) async {
    await _client.rpc('fn_join_community', params: {'p_user_id': userId, 'p_community_id': communityId});
  }
}
