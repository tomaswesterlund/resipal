import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/services/logger_service.dart';
import '../models/maintenance_fee_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceFeeDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  // In-memory cache using the Maintenance Fee ID as the key
  final Map<String, MaintenanceFeeModel> _cache = {};

  Stream<MaintenanceFeeModel> watchById(String id) {
    return _client.from('maintenance_fees').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('No maintenance fee found');
      }

      final model = MaintenanceFeeModel.fromJson(data.first);
      _cache[model.id] = model; // Update cache
      return model;
    });
  }

  Stream<List<MaintenanceFeeModel>> watchByContractId(String contractId) {
    return _client.from('maintenance_fees').stream(primaryKey: ['id']).eq('contract_id', contractId).map((data) {
      return data.map((i) {
        final model = MaintenanceFeeModel.fromJson(i);
        _cache[model.id] = model; // Update cache
        return model;
      }).toList();
    });
  }

  Stream<List<MaintenanceFeeModel>> watchByCommunityId(String communityId) {
    return _client.from('maintenance_fees').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((i) {
        final model = MaintenanceFeeModel.fromJson(i);
        _cache[model.id] = model; // Update cache
        return model;
      }).toList();
    });
  }

  Stream<List<MaintenanceFeeModel>> watchByPropertyId(String propertyId) {
    return _client.from('maintenance_fees').stream(primaryKey: ['id']).eq('property_id', propertyId).map((data) {
      return data.map((i) {
        final model = MaintenanceFeeModel.fromJson(i);
        _cache[model.id] = model; // Update cache
        return model;
      }).toList();
    });
  }

  MaintenanceFeeModel? getById(String id) => _cache[id];

  List<MaintenanceFeeModel> getByContractId(String contractId) =>
      _cache.values.where((m) => m.contractId == contractId).toList();

  List<MaintenanceFeeModel> getByPropertyId(String propertyId) =>
      _cache.values.where((m) => m.propertyId == propertyId).toList();

  Future<MaintenanceFeeModel> fetchById(String id) async {
    try {
      final item = await _client.from('maintenance_fees').select().eq('id', id).single();
      final model = MaintenanceFeeModel.fromJson(item);
      _cache[model.id] = model;
      return model;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'MaintenanceFeeDataSource.fetchById', stackTrace: s);
      rethrow;
    }
  }

  Future<void> updatePaymentDate({required String id, required DateTime paymentDate}) async {
    await _client.from('maintenance_fees').update({'payment_date': paymentDate.toIso8601String()}).eq('id', id);

    if (_cache.containsKey(id)) {
      _cache[id] = _cache[id]!.copyWith(paymentDate: paymentDate);
    }
  }
}
