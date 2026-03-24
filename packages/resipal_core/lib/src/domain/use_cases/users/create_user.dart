import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<UserId> call({
    required String userId,
    required String name,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String email
  }) async {
    final model = UpsertUserModel(
      id: userId,
      name: name,
      phoneNumber: phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber,
      email: email,
    );

    await _source.upsert(model);
    return userId;
  }
}
