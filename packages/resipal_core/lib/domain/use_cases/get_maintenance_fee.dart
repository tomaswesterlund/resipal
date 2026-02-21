import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/domain/use_cases/contracts/get_contract_ref.dart';

class GetMaintenanceFee {
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();
  final GetContractRef _getContractRef = GetContractRef();

  MaintenanceFeeEntity call(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Maintenance Fee $id not found in cache. Ensure the stream is active.');
    }

    return MaintenanceFeeEntity(
      id: id,
      contract: _getContractRef.fromId(model.contractId),
      createdAt: model.createdAt,
      amountInCents: model.amountInCents,
      dueDate: model.dueDate,
      paymentDate: model.paymentDate,
      fromDate: model.fromDate,
      toDate: model.toDate,
      note: model.note,
    );
  }
}
