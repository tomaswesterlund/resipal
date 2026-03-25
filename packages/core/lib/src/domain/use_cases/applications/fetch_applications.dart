import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class FetchApplications {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call() async {
    await _source.fetchAndCacheAll();
  }
}
