import 'package:get_it/get_it.dart';
import '../models/error_log_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorLogDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<void> insert(ErrorLogModel errorLog) async {
    await _client.from('error_logs').insert(errorLog.toMap());
  }
}
