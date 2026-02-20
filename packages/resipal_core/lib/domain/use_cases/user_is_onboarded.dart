import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';

class UserIsOnboarded {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<bool> call(String userId) async {
    final user = _source.getById(userId);
    return user != null;
  }
}
