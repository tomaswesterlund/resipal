import 'package:get_it/get_it.dart';
import 'package:core/src/data/models/access/upsert_access_log_model.dart';
import '../models/access/access_log_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessLogDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, AccessLogModel> _cache = {};

  Stream<List<AccessLogModel>> watchByCommunityId(String communityId) {
    return _client
        .from('access_logs')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = AccessLogModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        ).distinct();
  }

  Stream<List<AccessLogModel>> watchByInvitationId(String invitationId) {
    return _client
        .from('access_logs')
        .stream(primaryKey: ['id'])
        .eq('invitation_id', invitationId)
        .map(
          (data) => data.map((item) {
            final model = AccessLogModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        ).distinct();
  }

  List<AccessLogModel> getAccessLogsByInvitationId(String invitationId) =>
      _cache.values.where((x) => x.invitationId == invitationId).toList();

  Future upsert(UpsertAccessLogModel model) async {
    final response = await _client.from('access_logs').upsert(model.toMap()).select('id').single();
  }
}
