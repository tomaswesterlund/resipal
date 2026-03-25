import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/property_data_source.dart';

class FetchPropertyById {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  Future call(String id) async => await _source.fetchAndCacheById(id);
}
