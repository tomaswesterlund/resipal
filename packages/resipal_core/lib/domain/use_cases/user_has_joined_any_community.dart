import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';

class UserHasJoinedAnyCommunity {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  bool call(String userId) {
    final applications = _source.getByUserId(userId);

    if (applications.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
