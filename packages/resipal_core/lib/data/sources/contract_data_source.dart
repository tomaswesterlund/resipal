import 'package:get_it/get_it.dart';
import '../models/contract_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, ContractModel> _cache = {};

  Stream<ContractModel> watchById(String id) {
    return _client.from('contracts').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('No contract found.');
      }

      final model = ContractModel.fromJson(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<ContractModel>> watchByCommunityId(String communityId) {
    return _client.from('contracts').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((item) {
        final model = ContractModel.fromJson(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }

  ContractModel? getById(String id) => _cache[id];

  List<ContractModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();
}
