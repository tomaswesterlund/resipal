import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/maintenance_fee_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceFeeDataSource {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<MaintenanceFeeModel> getMaintenanceFeeById(String id) async {
    final item = await _client.from('maintenance_fees').select().eq('id', id).single();
    final model = MaintenanceFeeModel.fromJson(item);
    return model;
  }

  Future<List<MaintenanceFeeModel>> getMaintenanceFeeByContractId(String contractId) async {
    final items = await _client.from('maintenance_fees').select().eq('contract_id', contractId);
    final models = items.map((i) => MaintenanceFeeModel.fromJson(i)).toList();
    return models;
  }
}