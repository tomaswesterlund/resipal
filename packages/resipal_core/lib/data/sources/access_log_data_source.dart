import 'package:get_it/get_it.dart';
import '../models/access_log_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessLogDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<List<AccessLogModel>> getAccessLogsByInvitationId(
    String invitationId,
  ) async {
    final items = await _client
        .from('access_logs')
        .select()
        .eq('invitation_id', invitationId);
    final models = items.map((i) => AccessLogModel.fromJson(i)).toList();
    return models;
  }
}
