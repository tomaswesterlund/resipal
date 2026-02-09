import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvitationDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<InvitationModel>> watchInvitations() {
    return _client
        .from('invitations')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((item) => InvitationModel.fromJson(item)).toList());
  }

  Stream<List<InvitationModel>> watchInvitationsByUserId(String userId) {
    return _client
        .from('invitations')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) => data.map((item) => InvitationModel.fromJson(item)).toList());
  }

  Future createInvitation({
    required String userId,
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    await _client.rpc(
      'fn_create_invitation',
      params: {
        'p_user_id': userId,
        'p_property_id': propertyId,
        'p_visitor_id': visitorId,
        'p_from_date': DateUtils.dateOnly(fromDate.toUtc()).toIso8601String(),
        'p_to_date': DateUtils.dateOnly(toDate.toUtc()).toIso8601String(),
      },
    );
  }
}
