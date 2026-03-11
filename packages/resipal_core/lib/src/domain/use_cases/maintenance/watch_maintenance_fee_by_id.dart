import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchMaintenanceFeeById {
  final MaintenanceFeeDataSource _source = GetIt.I<MaintenanceFeeDataSource>();

  Stream<MaintenanceFeeEntity> call(String id) {
    return _source.watchById(id).map((x) {
      final fee = GetMaintenanceFee().call(id);
      return fee;
    });
  }
}
