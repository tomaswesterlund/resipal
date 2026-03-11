import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<UserId> call({
    required String name,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String email,
  }) async => await _source.createUser(
    name: name,
    phoneNumber: phoneNumber,
    emergencyPhoneNumber: emergencyPhoneNumber,
    email: email
  );
}
