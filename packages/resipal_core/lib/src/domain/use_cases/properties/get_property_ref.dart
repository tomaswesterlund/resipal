import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/refs/property_ref.dart';

class GetPropertyRef {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  PropertyRef call(String id) {
    final model = _source.getById(id);
    return PropertyRef(id: model.id, name: model.name);
  }
}
