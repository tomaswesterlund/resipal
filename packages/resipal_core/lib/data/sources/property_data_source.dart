import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/typedefs.dart';
import 'package:resipal_core/services/logger_service.dart';
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
      _logger.logException(exception: e, featureArea: 'PropertyDataSource.watchByCommunityId', stackTrace: s);
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
      _logger.logException(exception: e, featureArea: 'PropertyDataSource.watchByResidentId', stackTrace: s);
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

  Future<PropertyId> registerProperty({
    required String communityId,
    required String residentId,
    required String contractId,
    required String name,
    String? description,
  }) async {
    final propertyId = await _client.rpc(
      'fn_register_property',
      params: {
        'p_community_id': communityId,
        'p_resident_id': residentId,
        'p_contract_id': contractId,
        'p_name': name,
        'p_description': description,
      },
    );

    return propertyId;
  }
}
