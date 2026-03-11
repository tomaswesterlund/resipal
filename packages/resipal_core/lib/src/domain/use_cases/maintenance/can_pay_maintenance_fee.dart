import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CanPayMaintenanceFee {
  final LoggerService _logger = GetIt.I<LoggerService>();
  static const String _featureArea = 'CanPayMaintenanceFee';

  bool call({required String maintenanceFeeId}) {
    final fee = GetMaintenanceFee().call(maintenanceFeeId);
    final member = GetPropertyMember().call(propertyId: fee.property.id);
    final property = GetPropertyById().call(fee.property.id);

    // 1. Check Balance
    if (member.totalMemberBalanceInCents < fee.amountInCents) {
      _logDecision(
        allowed: false,
        reason: 'Insufficient balance: ${member.totalMemberBalanceInCents} < ${fee.amountInCents}',
        fee: fee,
        member: member,
        property: property,
      );
      return false;
    }

    // 2. Check if already paid
    if (fee.status == MaintenanceFeeStatus.paid) {
      _logDecision(allowed: false, reason: 'Fee is already paid.', fee: fee, member: member, property: property);
      return false;
    }

    // 3. Admin Override
    if (member.isAdmin) {
      _logDecision(allowed: true, reason: 'User is Admin.', fee: fee, member: member, property: property);
      return true;
    }

    // 4. Resident Validation
    if (property.resident == null) {
      _logDecision(
        allowed: false,
        reason: 'Property has no resident assigned.',
        fee: fee,
        member: member,
        property: property,
      );
      return false;
    }

    if (property.resident!.id == member.user.id) {
      _logDecision(
        allowed: true,
        reason: 'User is the assigned resident of the property.',
        fee: fee,
        member: member,
        property: property,
      );
      return true;
    }

    // Default Fallback
    _logDecision(
      allowed: false,
      reason: 'User has no legal relation to this property or fee.',
      fee: fee,
      member: member,
      property: property,
    );
    return false;
  }

  void _logDecision({
    required bool allowed,
    required String reason,
    required MaintenanceFeeEntity fee,
    required MemberEntity member,
    required PropertyEntity property,
  }) {
    _logger.info(
      featureArea: _featureArea,
      message: 'Payment eligibility check: ${allowed ? "ALLOWED" : "DENIED"}',
      metadata: {
        'reason': reason,
        'allowed': allowed,
        'fee': {'id': fee.id, 'amount': fee.amountInCents, 'status': fee.status.toString()},
        'member': member.toMap(),
        'property': property.toMap()
      },
    );
  }
}
