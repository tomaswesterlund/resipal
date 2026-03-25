import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvitationDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, InvitationModel> _cache = {};

  Stream<List<InvitationModel>> watchById(String id) {
    return _client.from('invitations').stream(primaryKey: ['id']).eq('id', id).map((data) {
      return data.map((item) {
        final model = InvitationModel.fromMap(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }

  Stream<List<InvitationModel>> watchByCommunityId(String communityId) {
    return _client.from('invitations').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((item) {
        final model = InvitationModel.fromMap(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }

  InvitationModel? getOptionalById(String id) => _cache[id];

  InvitationModel? getOptionalByQrCodeToken(String qrCodeToken) => _cache.values.where((x) => x.qrCodeToken == qrCodeToken).singleOrNull;

  List<InvitationModel> getByCommunityIdAndUserId({required String communityId, required String userId}) {
    return _cache.values.where((x) => x.communityId == communityId && x.userId == userId).toList();
  }

  Future<InvitationId> upsert({
    required String communityId,
    required String userId,
    required String propertyId,
    required String visitorId,
    required String qrCodeToken,
    required DateTime fromDate,
    required DateTime toDate,
    required int? maxEntries,
  }) async {
    try {
      final data = await _client
          .from('invitations')
          .upsert({
            'community_id': communityId,
            'user_id': userId,
            'property_id': propertyId,
            'visitor_id': visitorId,
            'qr_code_token': qrCodeToken,
            'from_date': fromDate.toIso8601String(),
            'to_date': toDate.toIso8601String(),
            'max_entries': maxEntries,
          })
          .select()
          .single();

      final model = InvitationModel.fromMap(data);

      _cache[model.id] = model;

      return model.id;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'InvitationDataSource.upsert', stackTrace: s);
      rethrow;
    }
  }
}
