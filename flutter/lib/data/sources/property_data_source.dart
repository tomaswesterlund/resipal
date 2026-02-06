import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<PropertyModel>> watchProperties() {
    try {
      return _client
          .from('properties')
          .stream(primaryKey: ['id'])
          .map((data) => data.map((item) => PropertyModel.fromJson(item)).toList());
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'PropertyDataSource.watchProperties', stackTrace: s);
      rethrow;
    }
  }
}
