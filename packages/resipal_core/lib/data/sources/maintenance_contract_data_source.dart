import 'package:get_it/get_it.dart';
import '../models/maintenance_contract_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceContractDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, MaintenanceContractModel> _cache = {};

  Stream<MaintenanceContractModel> watchById(String id) {
    return _client.from('maintenance_contracts').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('No maintenance contract found.');
      }

      final model = MaintenanceContractModel.fromJson(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<MaintenanceContractModel>> watchByCommunityId(String communityId) {
    return _client.from('maintenance_contracts').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((item) {
        final model = MaintenanceContractModel.fromJson(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }

  MaintenanceContractModel? getById(String id) => _cache[id];

  // Future<MaintenanceContractModel> getMaintenanceContractById(String id) async {
  //   final item = await _client.from('maintenance_contracts').select().eq('id', id).single();
  //   final model = MaintenanceContractModel.fromJson(item);
  //   return model;
  // }
}
