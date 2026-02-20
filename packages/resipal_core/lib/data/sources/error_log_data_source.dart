import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorLogDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<void> logError({
    required String errorMessage,
    required String? stackTrace,
    required String? platform,
    required String? appVersion,
    required String? featureArea,
    required Map<String, dynamic>? metadata,
  }) async {
    await _client.rpc(
      'fn_log_error',
      params: {
        'p_error_message': errorMessage,
        'p_stack_trace': stackTrace,
        'p_platform': platform,
        'p_app_version': appVersion,
        'p_feature_area': featureArea,
        'p_metadata': metadata ?? {}, // Ensure metadata isn't null for JSONB
      },
    );
  }
}
