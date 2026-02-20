import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';

class FetchApplications {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future byUserId(String userId) async {
    // TODO: Implemetn for "userId" only
    await _source.fetchAndCacheAll();
  }
}