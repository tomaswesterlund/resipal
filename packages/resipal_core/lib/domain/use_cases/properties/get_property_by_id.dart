import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/use_cases/communities/get_community_ref.dart';
import 'package:resipal_core/domain/use_cases/contracts/get_contract.dart';
import 'package:resipal_core/domain/use_cases/get_property_maintenance_fees.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetPropertyById {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();

  PropertyEntity call(String id) {
    final property = _source.getById(id);

    final community = GetCommunityRef().fromId(property.communityId);
    final contract = GetContract().optionalById(property.contractId);
    final createdBy = GetUserRef().fromId(property.createdBy);
    final fees = GetPropertyMaintenanceFees().call(property.id);
    final resident = property.residentId == null
        ? null
        : GetUserRef().fromId(property.residentId!);

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
