import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/visitor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Stream<List<VisitorModel>> watchVisitorsByUserId(String userId) {
    return _client
        .from('visitors')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((items) => items.map((json) => VisitorModel.fromJson(json)).toList());
  }

  Future<List<VisitorModel>> getVisitors() async {
    final items = await _client.from('visitors').select();
    final models = items.map((i) => VisitorModel.fromJson(i)).toList();
    return models;
  }

  Future<VisitorModel> getVisitorById(String id) async {
    final item = await _client.from('visitors').select().eq('id', id).single();
    final model = VisitorModel.fromJson(item);
    return model;
  }

  Future<List<VisitorModel>> getVisitorsByUserId(String userId) async {
    final items = await _client.from('visitors').select().eq('user_id', userId);
    final models = items.map((i) => VisitorModel.fromJson(i)).toList();
    return models;
  }

  Future createVisitor({required String userId, required String name, required String identificationPath}) async {
    await _client.rpc(
      'fn_create_visitor',
      params: {'p_user_id': userId, 'p_name': name, 'p_identification_path': identificationPath},
    );
  }
}
