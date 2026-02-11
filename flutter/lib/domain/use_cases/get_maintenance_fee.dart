import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';

class GetMaintenanceFee {
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();

  MaintenanceFeeEntity call(String id) {
    final model = _source.getById(id);

    return MaintenanceFeeEntity(
      id: id,
      contractId: model.contractId,
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
