import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/domain/typedefs.dart';

class CreateUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<UserId> call({required String name, required String phoneNumber, required String email}) async =>
      await _source.createUser(name: name, phoneNumber: phoneNumber, email: email);
}
