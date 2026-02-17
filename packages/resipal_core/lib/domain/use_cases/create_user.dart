import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';

class CreateUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future call(CreateUserCommand command) async {
    await _source.createUser(
      userId: command.userId,
      name: command.name,
      phoneNumber: command.phoneNumber,
      emergencyPhoneNumber: command.emergencyPhoneNumber,
      email: command.email,
    );
  }
}

class CreateUserCommand {
  final String userId;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;

  CreateUserCommand({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
  });
}
