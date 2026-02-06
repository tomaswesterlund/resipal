import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/community_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<CommunityModel>> watchCommunities() {
    return _client
        .from('communities')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((item) => CommunityModel.fromMap(item)).toList());
  }

  Future joinCommunity({required String userId, required String communityId}) async {
    await _client.rpc('fn_join_community', params: {'p_user_id': userId, 'p_community_id': communityId});
  }
}
