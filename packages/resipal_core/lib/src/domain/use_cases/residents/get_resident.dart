import 'package:resipal_core/src/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/src/domain/entities/property_registry.dart';
import 'package:resipal_core/src/domain/entities/resident_entity.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payments.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_properties.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_ref_by_id.dart';

class GetResident {
  ResidentEntity byCommunityAndUserId({required String communityId, required String userId}) {
    final user = GetUserRefById().call(userId: userId);
    final payments = GetPayments().byCommunityAndUserId(communityId: communityId, userId: userId);
    final ledger = PaymentLedgerEntity(payments);

    final properties = GetProperties().byByCommunityAndResidentId(communityId: communityId, residentId: userId);
    final registry = PropertyRegistry(properties);

    return ResidentEntity(id: user.id, user: user, paymentLedger: ledger, propertyRegistery: registry);
  }
}
