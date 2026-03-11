import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';
import 'package:resipal_core/src/domain/use_cases/contracts/get_contract.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_property_by_id.dart';
import 'package:resipal_core/src/domain/use_cases/get_property_maintenance_fees.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_ref_by_id.dart';

class GetUserProperties {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetUserRefById _getUserRef = GetUserRefById();

  List<PropertyEntity> call(String userId) {
    final models = _source.getByResidentId(userId);
    final properties = models.map((m) => GetPropertyById().call(m.id)).toList();
    return properties;
  }
}
