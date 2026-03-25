import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/data/models/membership/upsert_membership_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MembershipDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, MembershipModel> _cache = {};
  Map<String, MembershipModel> get cache => _cache;

  Stream<MembershipModel> watchById(String id) {
    return _client.from('memberships').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('Membership not found');
      }
      final model = MembershipModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<MembershipModel>> watchByCommunityId(String communityId) {
    return _client
        .from('memberships')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = MembershipModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  MembershipModel? getOptionalById(String id) => _cache[id];

  MembershipModel getByCommunityAndUserId({required String communityId, required String userId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.userId == userId).single;

  MembershipModel? getOptionalByCommunityAndUserId({required String communityId, required String userId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.userId == userId).singleOrNull;

  List<MembershipModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();

  List<MembershipModel> getByUserId(String userId) => _cache.values.where((x) => x.userId == userId).toList();

  Future fetchAndCacheAll() async {
    final items = await _client.from('memberships').select();
    for (var item in items) {
      final model = MembershipModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheByUserId(String userId) async {
    final items = await _client.from('memberships').select().eq('user_id', userId);
    for (var item in items) {
      final model = MembershipModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('memberships').select().eq('id', id).single();
    final model = MembershipModel.fromMap(item);

    _cache[model.id] = model;
  }

  Future<MembershipId> upsert(UpsertMembershipModel model) async {
    final response = await _client.from('memberships').upsert(model.toMap()).select('id').single();
    return response['id'] as MembershipId;
  }
}
