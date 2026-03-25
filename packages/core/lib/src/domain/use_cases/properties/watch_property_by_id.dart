import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/data/sources/property_data_source.dart';
import 'package:core/src/domain/entities/property_entity.dart';
import 'package:core/src/domain/use_cases/properties/get_property_by_id.dart';
import 'package:rxdart/rxdart.dart';

class WatchPropertyById {
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final MaintenanceFeeDataSource _maintenanceFeeDataSource = GetIt.I<MaintenanceFeeDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  Stream<PropertyEntity> call(String id) {
    return CombineLatestStream.combine2(
      _propertyDataSource.watchById(id),
      _maintenanceFeeDataSource.watchByPropertyId(id),
      (property, fees) {
        final property = _getProperty.call(id);
        return property;
      },
    ).distinct();
  }
}
