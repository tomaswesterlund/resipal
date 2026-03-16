import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, NotificationModel> _cache = {};

  Stream<List<NotificationModel>> watchByCommunityId(String communityId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = NotificationModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        )
        .distinct();
  }

  Future fetchAndCacheByCommunityId(String communityId) async {
    final items = await _client.from('notifications').select().eq('community_id', communityId);
    for (var item in items) {
      final model = NotificationModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  List<NotificationModel> getAdminNotificationsByCommunityAndUserId({
    required String communityId,
    required String userId,
  }) => _cache.values.where((x) => x.communityId == communityId && x.userId == userId && x.app == 'admin').toList();
}
