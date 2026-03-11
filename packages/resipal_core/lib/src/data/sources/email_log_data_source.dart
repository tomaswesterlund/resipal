import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/email_log_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailLogDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, EmailLogModel> _cache = {};

  Stream<List<EmailLogModel>> watchByInvitationId(String invitationId) {
    return _client
        .from('email_log')
        .stream(primaryKey: ['id'])
        .eq('invitation_id', invitationId)
        .map(
          (data) => data.map((item) {
            final model = EmailLogModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  Future<void> logAttempt({required String invitationId, required String resendId}) async {
    final map = {
      'invitation_id': invitationId,
      'resend_id': resendId,
      // created_at and created_by handled by DB defaults
    };

    await _client.from('email_log').insert(map);
  }

  Future<List<EmailLogModel>> fetchByInvitationId(String invitationId) async {
    final items = await _client.from('email_log').select().eq('invitation_id', invitationId);
    return items.map((item) {
      final model = EmailLogModel.fromMap(item);
      _cache[model.id] = model;
      return model;
    }).toList();
  }
}
