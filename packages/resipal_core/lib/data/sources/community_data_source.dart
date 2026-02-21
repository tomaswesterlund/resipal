import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/typedefs.dart';
import '../models/community_model.dart';
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

  /// Creates a new community and its first membership.
  /// Returns the [UUID] of the newly created community.
  Future<CommunityId> createCommunity({
    required String userId,
    required String name,
    required String? description,
    required String? location,
    required bool isAdmin,
    required bool isSecurity,
    required bool isUser,
  }) async {
    final communityId = await _client.rpc<String>(
      'fn_create_community',
      params: {
        'p_user_id': userId,
        'p_name': name,
        'p_description': description,
        'p_location': location,
        'p_is_admin': isAdmin,
        'p_is_security': isSecurity,
        'p_is_user': isUser,
      },
    );

    return communityId;
  }

  Future joinCommunity({required String userId, required String communityId}) async {
    await _client.rpc('fn_join_community', params: {'p_user_id': userId, 'p_community_id': communityId});
  }
}
