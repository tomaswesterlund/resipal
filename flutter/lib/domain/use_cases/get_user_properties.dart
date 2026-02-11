import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/use_cases/get_maintenance_contract.dart';

class GetUserProperties {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  List<PropertyEntity> call(String userId) {
    final models = _source.getByOwnerId(userId);

    final properties = models.map((model) {
      return PropertyEntity(
        id: model.id,
        communityId: model.communityId,
        ownerId: model.ownerId,
        createdAt: model.createdAt,
        name: model.name,
        description: model.description,
        contract: GetOptionalMaintenanceContract().call(model.contractId),
      );
    }).toList();

    return properties;
  }
}
