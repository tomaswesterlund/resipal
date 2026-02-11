import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/community_application_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityApplicationDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  final Map<String, CommunityApplicationModel> _cache = {};

  Stream<List<CommunityApplicationModel>> watchByUserId(String userId) {
    return _client.from('community_applications').stream(primaryKey: ['id']).eq('user_id', userId).map((data) {
      final models = data.map((item) => CommunityApplicationModel.fromMap(item)).toList();
      models.map((model) => _cache[model.id] = model);
      return models;
    });
  }

  List<CommunityApplicationModel> getAll() => _cache.values.toList();

  CommunityApplicationModel? getById(String id) => _cache[id];

  List<CommunityApplicationModel> getByUserId(String userId) => _cache.values.where((c) => c.userId == userId).toList();

  Future fetchAll() async {
    final items = await _client.from('community_applications').select();
    for (var item in items) {
      final model = CommunityApplicationModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future joinCommunity({required String userId, required String communityId}) async {
    await _client.rpc('fn_join_community', params: {'p_user_id': userId, 'p_community_id': communityId});
  }
}
