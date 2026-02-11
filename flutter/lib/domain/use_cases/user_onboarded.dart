import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/user_data_source.dart';

class UserOnboarded {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  Future<bool> call(String id) async {
    return await _source.userExists(id);
  }
}