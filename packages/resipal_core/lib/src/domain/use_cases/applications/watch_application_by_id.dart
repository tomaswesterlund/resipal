import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchApplicationById {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Stream<ApplicationEntity> call({required String id}) {
    return _source.watchById(id).map((x) => GetApplicationById().call(id: id));
  }
}
