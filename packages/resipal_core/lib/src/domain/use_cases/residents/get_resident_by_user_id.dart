import 'package:resipal_core/lib.dart';

class GetResidentByUserId {
  ResidentEntity call(String userId) {
    final user = GetUserRefById().call(userId: userId);
    final properties = GetPropertiesByResidentId().call(residentId: userId);
    final payments = GetPaymentByUserId().call(userId: userId);
    final ledger = PaymentLedgerEntity(payments);
    final registry = PropertyRegistry(properties);

    return ResidentEntity(id: user.id, user: user, paymentLedger: ledger, propertyRegistery: registry);
  }
}
