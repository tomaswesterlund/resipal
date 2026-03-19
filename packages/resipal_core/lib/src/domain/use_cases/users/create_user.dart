import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateUser {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<UserId> call({
    required String name,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String email
  }) async {
    final model = UpsertUserModel(
      id: _sessionService.userId,
      name: name,
      phoneNumber: phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber,
      email: email,
    );

    final userId = _source.upsert(model);
    return userId;
  }
}
