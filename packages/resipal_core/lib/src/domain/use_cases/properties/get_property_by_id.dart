import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';
import 'package:resipal_core/src/domain/use_cases/communities/get_community_ref_by_id.dart';
import 'package:resipal_core/src/domain/use_cases/contracts/get_contract.dart';
import 'package:resipal_core/src/domain/use_cases/get_property_maintenance_fees.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_ref_by_id.dart';

class GetPropertyById {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  PropertyEntity call(String id) {
    final property = _source.getById(id);

    final community = GetCommunityRefById().call(communityId: property.communityId);
    final contract = GetContract().optionalById(property.contractId);
    final createdBy = GetUserRefById().call(userId: property.createdBy);
    final fees = GetPropertyMaintenanceFees().call(property.id);
    final resident = property.residentId == null ? null : GetUserRefById().call(userId: property.residentId!);

    return PropertyEntity(
      id: property.id,
      community: community,
      resident: resident,
      createdAt: property.createdAt,
      createdBy: createdBy,
      name: property.name,
      description: property.description,
      contract: contract,
      fees: fees,
    );
  }
}
