import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/rxdart.dart';

class WatchPropertiesByCommunity {
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final MaintenanceFeeDataSource _maintenanceFeeDataSource = GetIt.I<MaintenanceFeeDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  Stream<List<PropertyEntity>> call(String communityId) {
    return CombineLatestStream.combine2(
      _propertyDataSource.watchByCommunityId(communityId),
      _maintenanceFeeDataSource.watchByCommunityId(communityId),
      (properties, fees) {
        final entities = properties.map((x) => _getProperty(x.id)).toList();
        return entities;
      },
    );
  }
}
