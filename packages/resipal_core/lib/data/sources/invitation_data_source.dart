import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvitationDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, InvitationModel> _cache = {};

  Stream<List<InvitationModel>> watchByUserId(String userId) {
    return _client.from('invitations').stream(primaryKey: ['id']).eq('user_id', userId).map((data) {
      return data.map((item) {
        final model = InvitationModel.fromJson(item);
        _cache[model.id] = model; // Update cache
        return model;
      }).toList();
    });
  }

    Stream<List<InvitationModel>> watchByCommunityId(String communityId) {
    return _client.from('invitations').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((item) {
        final model = InvitationModel.fromJson(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }


  InvitationModel? getById(String id) => _cache[id];

  List<InvitationModel> getByUserId(String userId) {
    return _cache.values.where((m) => m.userId == userId).toList();
  }

  Future createInvitation({
    required String communityId,
    required String userId,
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    await _client.rpc(
      'fn_create_invitation',
      params: {
        'p_community_id': communityId,
        'p_user_id': userId,
        'p_property_id': propertyId,
        'p_visitor_id': visitorId,
        'p_from_date': DateUtils.dateOnly(fromDate.toUtc()).toIso8601String(),
        'p_to_date': DateUtils.dateOnly(toDate.toUtc()).toIso8601String(),
      },
    );
    // Note: The stream will automatically pick up the new invitation
    // from Supabase and update the cache for us.
  }
}
