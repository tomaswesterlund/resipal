import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MembershipDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, MembershipModel> _cache = {};

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

  MembershipModel? getById(String id) => _cache[id];

  MembershipModel getByCommunityAndUserId({required String communityId, required String userId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.userId == userId).single;

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

  Future<MembershipId> createMembership({
    required String communityId,
    required String userId,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async {
    final membershipId = await _client.rpc<String>(
      'fn_create_membership',
      params: {
        'p_community_id': communityId,
        'p_user_id': userId,
        'p_is_admin': isAdmin,
        'p_is_resident': isResident,
        'p_is_security': isSecurity,
      },
    );

    return membershipId;
  }

  Future upsert(MembershipModel model) async {
    await _client.from('memberships').upsert(model.toMap());
  }
}
