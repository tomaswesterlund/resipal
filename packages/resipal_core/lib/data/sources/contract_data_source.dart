import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/typedefs.dart';
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

      final model = ContractModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<ContractModel>> watchByCommunityId(String communityId) {
    return _client.from('contracts').stream(primaryKey: ['id']).eq('community_id', communityId).map((data) {
      return data.map((item) {
        final model = ContractModel.fromMap(item);
        _cache[model.id] = model;
        return model;
      }).toList();
    });
  }

  ContractModel? getById(String id) => _cache[id];

  List<ContractModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('contracts').select().eq('id', id).single();
    final model = ContractModel.fromMap(item);

    _cache[model.id] = model;
  }

  /// Creates a new contract for a specific community.
  /// Returns the [ContractId] (UUID) of the newly created contract.
  Future<ContractId> createContract({
    required String communityId,
    required String name,
    required int amountInCents,
    required String period,
    required String? description,
  }) async {
    final contractId = await _client.rpc<String>(
      'fn_create_contract',
      params: {
        'p_community_id': communityId,
        'p_name': name,
        'p_amount_in_cents': amountInCents,
        'p_period': period.toLowerCase(),
        'p_description': description,
      },
    );

    return contractId;
  }
}
