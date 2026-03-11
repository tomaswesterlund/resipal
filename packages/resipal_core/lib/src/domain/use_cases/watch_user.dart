import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/user_data_source.dart';
import 'package:resipal_core/src/domain/entities/user_entity.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_by_id.dart';

class WatchUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Stream<UserEntity> call(String id) {
    return _source.watchById(id).asyncMap((model) async {
      return await GetUserById().call(id);
    });
  }
}
