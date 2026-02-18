import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/use_cases/get_property.dart';

class GetCommunityProperties {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  List<PropertyEntity> call(String communityId) {
    final models = _source.getByCommunityId(communityId);
    final properties = models.map((m) => GetProperty().call(m.id)).toList();
    return properties;
  }
}
