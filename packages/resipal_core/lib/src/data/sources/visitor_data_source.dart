import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, VisitorModel> _cache = {};

  Stream<List<VisitorModel>> watchByUserId(String userId) {
    return _client
        .from('visitors')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map(
          (items) => items.map((item) {
            final model = VisitorModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  Stream<List<VisitorModel>> watchByCommunityId(String communityId) {
    return _client
        .from('visitors')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (items) => items.map((item) {
            final model = VisitorModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  VisitorModel? getById(String id) => _cache[id];

  List<VisitorModel> getByCommunityIdAndUserId({required String communityId, required String userId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.userId == userId).toList();

  Future<VisitorId> upsert({
    required String communityId,
    required String userId,
    required String name,
    required String identificationImagePath,
  }) async {
    try {
      // 1. Usamos .select().single() para obtener la fila procesada
      final data = await _client
          .from('visitors')
          .upsert({
            'community_id': communityId,
            'user_id': userId,
            'name': name,
            'identification_path': identificationImagePath,
          })
          .select()
          .single();

      final model = VisitorModel.fromMap(data);

      _cache[model.id] = model;

      return model.id;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ApplicationDataSource.upsert', stackTrace: s);
      rethrow;
    }
  }
}
