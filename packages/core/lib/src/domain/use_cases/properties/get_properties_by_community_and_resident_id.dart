import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/property_data_source.dart';
import 'package:core/src/domain/entities/property_entity.dart';
import 'package:core/src/domain/use_cases/properties/get_property_by_id.dart';

class GetPropertiesByCommunityAndResidentId {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  List<PropertyEntity> call({required String communityId, required String residentId}) {
    final properties = _source.getByCommunityAndResidentId(communityId: communityId, residentId: residentId);
    final list = properties.map((x) => _getProperty.call(x.id)).toList();
    return list;
  }
}
