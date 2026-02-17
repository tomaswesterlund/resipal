import 'package:get_it/get_it.dart';
import '../models/visitor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, VisitorModel> _cache = {};

  Stream<List<VisitorModel>> watchByUserId(String userId) {
    return _client
        .from('visitors')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map(
          (items) => items.map((item) {
            final model = VisitorModel.fromJson(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

    Stream<List<VisitorModel>> watchByCommunityId(String communityId) {
    return _client
        .from('visitors')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (items) => items.map((item) {
            final model = VisitorModel.fromJson(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  VisitorModel? getById(String id) => _cache[id];

  List<VisitorModel> getByUserId(String userId) => _cache.values.where((m) => m.userId == userId).toList();

  Future createVisitor({required String communityId, required String userId, required String name, required String identificationPath}) async {
    await _client.rpc(
      'fn_create_visitor',
      params: {'p_community_id': communityId, 'p_user_id': userId, 'p_name': name, 'p_identification_path': identificationPath},
    );
  }
}
