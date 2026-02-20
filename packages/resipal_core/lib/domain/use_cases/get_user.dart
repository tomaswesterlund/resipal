import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payments.dart';
import 'package:resipal_core/domain/use_cases/get_user_access_registry.dart';
import 'package:resipal_core/domain/use_cases/get_user_invitations.dart';
import 'package:resipal_core/domain/use_cases/get_user_properties.dart';

class GetUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserEntity call(String id) {
    final user = _source.getById(id);

    if (user == null) {
      throw Exception('User $id not found in cache. Ensure the stream is active.');
    }

    final userAccessRegistry = GetUserAccessRegistry().call(user.id);
    final payments = GetPayments().byUserId(user.id);
    final properties = GetUserProperties().call(id);

    return UserEntity(
      id: user.id,
      createdAt: user.createdAt,
      name: user.name,
      phoneNumber: user.phoneNumber,
      emergencyPhoneNumber: user.emergencyPhoneNumber,
      email: user.email,
      userAccessRegistry: userAccessRegistry,
      invitations: GetUserInvitations().call(id),
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistery: PropertyRegistry(properties),
    );
  }
}
