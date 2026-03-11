import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/maintenance/can_pay_maintenance_fee.dart';

class PayMaintenanceFee {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();

  Future call(String id) async {
    final fee = GetMaintenanceFee().call(id);
    final member = GetSignedInMember().call();

    final canPay = CanPayMaintenanceFee().call(maintenanceFeeId: id);

    if (!canPay) {
      _logger.error(
        featureArea: 'PayMaintenanceFee',
        exception: 'Can pay is not fulfilled',
        metadata: {'fee': fee.toMap(), 'member': member.toMap()},
      );
      throw Exception('Can pay is not fulfilled.');
    }

    await _source.updatePaymentDate(id: id, paymentDate: DateTime.now());
  }
}
