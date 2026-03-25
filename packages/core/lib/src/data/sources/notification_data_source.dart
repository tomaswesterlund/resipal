import 'package:get_it/get_it.dart';
import 'package:core/src/data/models/notification/notification_model.dart';
import 'package:core/src/data/models/notification/upsert_notification_model.dart';
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

  Stream<List<NotificationModel>> watchByUserId(String userId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
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

  List<NotificationModel> getNotificationsByCommunityAndUserId({
    required String communityId,
    required String userId,
    required String app,
  }) => _cache.values.where((x) => x.communityId == communityId && x.userId == userId && x.app == app).toList();

  Future updateReadDate({required String id, required DateTime readDate}) async {
    await _client.from('notifications').update({'read_date': readDate.toIso8601String()}).eq('id', id);
  }

  Future<void> markAllAsRead({required String communityId, required String userId, required DateTime readDate}) async {
    await _client
        .from('notifications')
        .update({'read_date': readDate.toIso8601String()})
        .eq('community_id', communityId)
        .eq('user_id', userId)
        .isFilter('read_date', null);
  }

  Future upsert(UpsertNotificationModel model) async {
    await _client.from('notifications').upsert(model.toMap());
  }
}
