import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();
  static const String _tableName = 'logs';

  /// Persists an Error/Exception log to the database
  Future<void> logError({
    required String errorMessage,
    String? stackTrace,
    required String platform,
    required String appVersion,
    required String featureArea,
    Map<String, dynamic>? metadata,
  }) async {
    await _insertLog(
      message: errorMessage,
      level: 'ERROR',
      stackTrace: stackTrace,
      platform: platform,
      appVersion: appVersion,
      featureArea: featureArea,
      metadata: metadata,
    );
  }

  /// Persists an Operational/Business info log to the database
  Future<void> logInfo({
    required String message,
    required String platform,
    required String appVersion,
    required String featureArea,
    Map<String, dynamic>? metadata,
  }) async {
    final logData = {
      'message': message,
      'level': 'INFO',
      'stack_trace': null,
      'platform': platform,
      'app_version': appVersion,
      'feature_area': featureArea,
      'metadata': metadata ?? {},
      'created_by': _client.auth.currentUser?.id, // Automatically tag the user if signed in
    };

    await _client.from(_tableName).insert(logData);
  }

  /// Private helper to perform the Supabase Insert
  Future<void> _insertLog({
    required String message,
    required String level,
    required String? stackTrace,
    required String platform,
    required String appVersion,
    required String featureArea,
    required Map<String, dynamic>? metadata,
  }) async {
    // We omit 'id' and 'created_at' so Supabase generates them automatically
    final logData = {
      'message': message,
      'level': level,
      'stack_trace': stackTrace,
      'platform': platform,
      'app_version': appVersion,
      'feature_area': featureArea,
      'metadata': metadata ?? {},
      'created_by': _client.auth.currentUser?.id, // Automatically tag the user if signed in
    };

    await _client.from(_tableName).insert(logData);
  }
}
