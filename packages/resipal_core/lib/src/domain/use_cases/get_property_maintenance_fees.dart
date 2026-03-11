import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/src/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/src/domain/use_cases/get_maintenance_fee.dart';

class GetPropertyMaintenanceFees {
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();
  final GetMaintenanceFee _getMaintenanceFee = GetMaintenanceFee();

  List<MaintenanceFeeEntity> call(String propertyId) {
    final models = _source.getByPropertyId(propertyId);
    final fees = models.map((model) => _getMaintenanceFee.call(model.id)).toList();
    return fees;

  }
}