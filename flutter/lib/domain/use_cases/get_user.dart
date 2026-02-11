import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/entities/ledger_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/use_cases/get_community_ref.dart';
import 'package:resipal/domain/use_cases/get_user_community_applications.dart';
import 'package:resipal/domain/use_cases/get_user_invitations.dart';
import 'package:resipal/domain/use_cases/get_user_payments.dart';
import 'package:resipal/domain/use_cases/get_user_properties.dart';

class GetUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserEntity call(String id) {
    final model = _source.getById(id);

    if (model == null) {
      if (model == null) {
        throw Exception('User $id not found in cache. Ensure the stream is active.');
      }
    }

    return UserEntity(
      id: model.id,
      createdAt: model.createdAt,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      applications: GetUserCommunityApplications().call(model.id),
      invitations: GetUserInvitations().call(id),
      ledger: LedgerEntity(userId: model.id),
      payments: GetUserPayments().call(id),
      properties: GetUserProperties().call(id),
    );
  }
}
