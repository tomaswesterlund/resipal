import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/use_cases/get_maintenance_contract.dart';
import 'package:resipal_core/domain/use_cases/get_property_maintenance_fees.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetUserProperties {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetUserRef _getUserRef = GetUserRef();

  List<PropertyEntity> call(String userId) {
    final models = _source.getByOwnerId(userId);

    final properties = models.map((property) {
      return PropertyEntity(
        id: property.id,
        communityId: property.communityId,
        owner: property.ownerId != null ? _getUserRef.fromId(property.ownerId!) : null,
        createdAt: property.createdAt,
        name: property.name,
        description: property.description,
        contract: GetOptionalMaintenanceContract().call(property.contractId),
        fees: GetPropertyMaintenanceFees().call(property.id),
      );
    }).toList();

    return properties;
  }
}
