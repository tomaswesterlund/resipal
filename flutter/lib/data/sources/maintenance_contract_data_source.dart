import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/maintenance_contract_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceContractDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<MaintenanceContractModel> getMaintenanceContractById(String id) async {
    final item = await _client.from('maintenance_contracts').select().eq('id', id).single();
    final model = MaintenanceContractModel.fromJson(item);
    return model;
  }

  Future<MaintenanceContractModel> getMaintenanceContractByPropertyId(String propertyId) async {
    final item = await _client.from('maintenance_contracts').select().eq('property_id', propertyId).single();
    final model = MaintenanceContractModel.fromJson(item);
    return model;
  }
}