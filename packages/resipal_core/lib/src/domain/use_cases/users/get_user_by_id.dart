import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetUserById {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserEntity call(String id) {
    final user = _source.getById(id);

    if (user == null) {
      throw Exception('User $id not found in cache. Ensure the stream is active.');
    }

    final payments = GetPaymentByUserId().call(userId: user.id);
    final properties = GetUserProperties().call(id);

    return UserEntity(
      // Identity & Metadata
      id: user.id,
      createdAt: user.createdAt,
      createdBy: user.createdBy,

      // Personal Info
      name: user.name,
      phoneNumber: user.phoneNumber,
      emergencyPhoneNumber: user.emergencyPhoneNumber,
      email: user.email,

      // Role Flags
      isAdmin: user.isAdmin,
      isResident: user.isResident,
      isSecurity: user.isSecurity,

      // Related Data Entities
      invitations: GetUserInvitations().call(id),
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistery: PropertyRegistry(properties),
    );
  }
}
