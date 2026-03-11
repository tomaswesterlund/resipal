import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/application/create_application_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, ApplicationModel> _cache = {};

  Stream<ApplicationModel> watchById(String id) {
    return _client.from('applications').stream(primaryKey: ['id']).eq('id', id).map((data) {
      final model = ApplicationModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<ApplicationModel>> watchByCommunityId(String communityId) {
    return _client
        .from('applications')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = ApplicationModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  ApplicationModel? getById(String id) => _cache[id];

  List<ApplicationModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();

  List<ApplicationModel> getByUserId(String userId) => _cache.values.where((x) => x.userId == userId).toList();

  Future<void> fetchAndCacheAll() async {
    try {
      final items = await _client.from('applications').select();
      for (var item in items) {
        final model = ApplicationModel.fromMap(item);
        _cache[model.id] = model;
      }
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ApplicationDataSource.fetchAndCacheAll', stackTrace: s);
      rethrow;
    }
  }

  Future<void> fetchAndCacheById(String id) async {
    try {
      final item = await _client.from('applications').select().eq('id', id).single();
      final model = ApplicationModel.fromMap(item);
      _cache[model.id] = model;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ApplicationDataSource.fetchAndCacheById', stackTrace: s);
      rethrow;
    }
  }

  Future<void> upsert(ApplicationModel model) async {
    try {
      await _client.from('applications').upsert(model.toMap());
      _cache[model.id] = model;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ApplicationDataSource.upsert', stackTrace: s);
      rethrow;
    }
  }

  Future<void> createApplication(CreateApplicationDto dto) async {
    await _client.from('applications').insert(dto.toMap());
  }
}
