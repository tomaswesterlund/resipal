import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/community_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  // In-memory cache using the Community ID as the key
  final Map<String, CommunityModel> _cache = {};

  Stream<List<CommunityModel>> watchCommunities() {
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

  Stream<CommunityModel> watchCommunityById(String id) {
    return _client.from('communities').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('Community not found');
      }

      final model = CommunityModel.fromMap(data.first);
      _cache[model.id] = model; // Update cache
      return model;
    });
  }

  List<CommunityModel> getAll() => _cache.values.toList();

  CommunityModel getById(String id) => _cache[id]!;

  Future<CommunityModel> getCommunityById(String id) async {
    final item = await _client.from('communities').select().eq('id', id).single();
    final model = CommunityModel.fromMap(item);

    _cache[model.id] = model; // Update cache on manual fetch
    return model;
  }

  Future joinCommunity({required String userId, required String communityId}) async {
    await _client.rpc('fn_join_community', params: {'p_user_id': userId, 'p_community_id': communityId});
  }
}
