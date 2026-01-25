import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvitationDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<List<InvitationModel>> getInvitations() async {
    final items = await _client.from('invitations').select();
    final models = items.map((i) => InvitationModel.fromJson(i)).toList();
    return models;
  }

  Future<List<InvitationModel>> getActiveInvitationsByUserId(String userId) async {
    final now = DateTime.now();
    final items = await _client.from('invitations').select().eq('user_id', userId).lte('from_date', now).gte('to_date', now);
    final models = items.map((i) => InvitationModel.fromJson(i)).toList();
    return models;
  }

  Future<List<InvitationModel>> getInvitationsByUserId(String userId) async {
    return await getInvitations();
  }
}
