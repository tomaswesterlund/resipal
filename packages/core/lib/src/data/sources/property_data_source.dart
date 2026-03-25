import 'package:get_it/get_it.dart';
import 'package:core/src/domain/typedefs.dart';
import 'package:core/src/services/logger_service.dart';
import '../models/property_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, PropertyModel> _cache = {};

  Stream<PropertyModel> watchById(String id) {
    return _client
        .from('properties')
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map(
          (data) => data
              .map((item) {
                final model = PropertyModel.fromMap(item);
                _cache[model.id] = model;
                return model;
              })
              .toList()
              .first,
        );
  }

  Stream<List<PropertyModel>> watchByCommunityId(String communityId) {
    try {
      return _client
          .from('properties')
          .stream(primaryKey: ['id'])
          .eq('community_id', communityId)
          .map(
            (data) => data.map((item) {
              final model = PropertyModel.fromMap(item);
              _cache[model.id] = model;
              return model;
            }).toList(),
          );
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'PropertyDataSource.watchByCommunityId', stackTrace: s);
      rethrow;
    }
  }

  Stream<List<PropertyModel>> watchByResidentId(String residentId) {
    try {
      return _client
          .from('properties')
          .stream(primaryKey: ['id'])
          .eq('resident_id', residentId)
          .map(
            (data) => data.map((item) {
              final model = PropertyModel.fromMap(item);
              _cache[model.id] = model;
              return model;
            }).toList(),
          );
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'PropertyDataSource.watchByResidentId', stackTrace: s);
      rethrow;
    }
  }

  PropertyModel getById(String id) => _cache[id]!;

  List<PropertyModel> getByCommunityId(String communityId) =>
      _cache.values.where((m) => m.communityId == communityId).toList();

  List<PropertyModel> getByResidentId(String residentId) =>
      _cache.values.where((m) => m.residentId == residentId).toList();

  List<PropertyModel> getByCommunityAndResidentId({required String communityId, required String residentId}) =>
      _cache.values.where((x) => x.communityId == communityId && x.residentId == residentId).toList();

  Future<PropertyModel> fetchAndCacheById(String id) async {
    final item = await _client.from('properties').select().eq('id', id).single();
    final model = PropertyModel.fromMap(item);
    _cache[model.id] = model;
    return model;
  }

  Future<List<PropertyModel>> fetchAndCacheByResidentId(String residentId) async {
    final data = await _client.from('properties').select().eq('resident_id', residentId);

    final models = data.map((item) {
      final model = PropertyModel.fromMap(item);
      _cache[model.id] = model;
      return model;
    }).toList();

    return models;
  }

  Future<PropertyId> upsert({
    required String communityId,
    required String? residentId,
    required String? contractId,
    required String name,
    required String? description,
  }) async {
    try {
      // 1. Usamos .select().single() para obtener la fila procesada
      final data = await _client
          .from('properties')
          .upsert({
            'community_id': communityId,
            'contract_id': contractId,
            'resident_id': residentId,
            'name': name,
            'description': description,
          })
          .select()
          .single();

      final model = PropertyModel.fromMap(data);

      _cache[model.id] = model;

      return model.id;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ApplicationDataSource.upsert', stackTrace: s);
      rethrow;
    }
  }
}
