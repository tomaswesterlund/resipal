import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/membership_model.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MembershipDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  final Map<String, MembershipModel> _cache = {};

  Stream<List<MembershipModel>> watchByUserId(String userId) {
    return _client
        .from('memberships')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) {
          final models = data
              .map((item) => MembershipModel.fromMap(item))
              .toList();
          models.map((model) => _cache[model.id] = model);
          for (var model in models) {
            _cache[model.id] = model;
          }
          return models;
        })
        .handleError((e, s) {
          _logger.logException(
            exception: e,
            featureArea: 'MembershipDataSource.watchByUserId',
            stackTrace: s,
            metadata: {'userId': userId},
          );
        });
  }

  Stream<List<MembershipModel>> watchByCommunityId(String communityId) {
    return _client
        .from('memberships')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map((data) {
          final models = data
              .map((item) => MembershipModel.fromMap(item))
              .toList();
          models.map((model) => _cache[model.id] = model);
          for (var model in models) {
            _cache[model.id] = model;
          }
          return models;
        })
        .handleError((e, s) {
          _logger.logException(
            exception: e,
            featureArea: 'MembershipDataSource.watchByCommunityId',
            stackTrace: s,
            metadata: {'communityId': communityId},
          );
        });
  }

  List<MembershipModel> getAll() => _cache.values.toList();

  MembershipModel? getById(String id) => _cache[id];

  List<MembershipModel> getByCommunityId(String communityId) =>
      _cache.values.where((c) => c.communityId == communityId).toList();

  List<MembershipModel> getByUserId(String userId) =>
      _cache.values.where((c) => c.userId == userId).toList();

  Future fetchAndCacheAll() async {
    final items = await _client.from('memberships').select();
    for (var item in items) {
      final model = MembershipModel.fromMap(item);
      _cache[model.id] = model;
    }
  }
}
