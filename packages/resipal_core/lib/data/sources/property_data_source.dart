import 'package:get_it/get_it.dart';
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
                final model = PropertyModel.fromJson(item);
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
              final model = PropertyModel.fromJson(item);
              _cache[model.id] = model;
              return model;
            }).toList(),
          );
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'PropertyDataSource.watchByCommunityId',
        stackTrace: s,
      );
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
              final model = PropertyModel.fromJson(item);
              _cache[model.id] = model;
              return model;
            }).toList(),
          );
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'PropertyDataSource.watchByResidentId',
        stackTrace: s,
      );
      rethrow;
    }
  }

  PropertyModel getById(String id) => _cache[id]!;

  List<PropertyModel> getByCommunityId(String communityId) =>
      _cache.values.where((m) => m.communityId == communityId).toList();

  List<PropertyModel> getByResidentId(String residentId) =>
      _cache.values.where((m) => m.residentId == residentId).toList();

  Future<List<PropertyModel>> fetchByResidentId(String residentId) async {
    final data = await _client
        .from('properties')
        .select()
        .eq('resident_id', residentId);
    final models = data.map((item) => PropertyModel.fromJson(item)).toList();
    return models;
  }
}
