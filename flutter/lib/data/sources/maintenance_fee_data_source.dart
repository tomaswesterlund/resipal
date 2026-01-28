import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/maintenance_fee_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceFeeDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<MaintenanceFeeModel> getMaintenanceFeeById(String id) async {
    try {
      final item = await _client
          .from('maintenance_fees')
          .select()
          .eq('id', id)
          .single();
      final model = MaintenanceFeeModel.fromJson(item);
      return model;
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'MaintenanceFeeDataSource.getMaintenanceFeeById',
        stackTrace: stack,
        metadata: {'id': id},
      );
      rethrow;
    }
  }

  Future<List<MaintenanceFeeModel>> getMaintenanceFeeByContractId(
    String contractId,
  ) async {
    try {
      final items = await _client
          .from('maintenance_fees')
          .select()
          .eq('contract_id', contractId);
      final models = items.map((i) => MaintenanceFeeModel.fromJson(i)).toList();
      return models;
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'MaintenanceFeeDataSource.getMaintenanceFeeByContractId',
        stackTrace: stack,
        metadata: {'contractId': contractId},
      );
      rethrow;
    }
  }
}
