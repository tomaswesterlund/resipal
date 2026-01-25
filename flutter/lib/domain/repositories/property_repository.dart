import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/refs/property_ref.dart';

class PropertyRepository {
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();

  Future<PropertyRef> getPropertyRefById(String id) async {
    final model = await _propertyDataSource.getPropertyById(id);
    final ref =  PropertyRef(id: model.id, name: model.name);
    return ref;
  }
}
