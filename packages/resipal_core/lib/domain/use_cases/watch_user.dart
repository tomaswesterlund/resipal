import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/domain/use_cases/get_user.dart';

class WatchUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Stream<UserEntity> call(String id) {
    return _source.watchById(id).asyncMap((model) async {
      return await GetUser().call(id);
    });
  }
}
