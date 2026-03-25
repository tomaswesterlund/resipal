import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/user_data_source.dart';

class UserIsOnboarded {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<bool> call(String id) async {
    final user =  _source.getOptionalById(id);
    return user != null;
  }
}
