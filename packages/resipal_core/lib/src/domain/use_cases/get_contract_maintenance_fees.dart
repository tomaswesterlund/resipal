import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/src/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/src/domain/use_cases/get_maintenance_fee.dart';

class GetContractMaintenanceFees {
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();
  List<MaintenanceFeeEntity> call(String contractId) {
    final models = _source.getByContractId(contractId);
    final entities = models.map((m) => GetMaintenanceFee().call(m.id)).toList();
    return entities;
  }
}
