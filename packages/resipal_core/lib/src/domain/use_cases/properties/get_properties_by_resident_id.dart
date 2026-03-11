import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_property_by_id.dart';

class GetPropertiesByResidentId {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  List<PropertyEntity> call({required String residentId}) {
    final models = _source.getByResidentId(residentId);
    final payments = models.map((m) => _getProperty.call(m.id)).toList();
    return payments;
  }
}
