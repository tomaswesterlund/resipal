import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/contract_data_source.dart';

class FetchContract {
  final ContractDataSource _source = GetIt.I<ContractDataSource>();

  Future call(String id) async {
    await _source.fetchAndCacheById(id);
  }
}
