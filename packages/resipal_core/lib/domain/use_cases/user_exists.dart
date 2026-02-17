import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';

class UserExists {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<bool> call(String userId) async {
    final userExistsInCache = _source.userExistsInCache(userId);
    if (userExistsInCache) return true;

    final userExistsInDatabase = await _source.userExistsInDatabase(userId);
    return userExistsInDatabase;
  }
}
