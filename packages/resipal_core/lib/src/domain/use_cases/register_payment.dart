import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class RegisterPayment {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _session = GetIt.I<SessionService>();
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future<void> call({
    required String residentId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    const String featureArea = 'RegisterPayment';

    try {
      _logger.info(
        featureArea: 'SessionService',
        message: '[$featureArea] Starting payment registration for user: $residentId in community: $_session.communityId');

      final signedInMember = GetSignedInMember().call();

      final bool isSelf = signedInMember.user.id == residentId;
      final bool isAdmin = signedInMember.isAdmin == true;

      if (!isSelf && !isAdmin) {
        final String roleStatus = isAdmin ? 'Admin' : 'Resident';
        final String error =
            'Authorization Denied: User ${signedInMember.user.id} ($roleStatus) attempted to register a payment for $residentId but is not the owner or an Admin.';

        // Log the specific failure with the user's role context
        _logger.debug('[$featureArea] $error');

        // Send to Supabase via logException for security monitoring
        await _logger.error(
          featureArea: featureArea,
          exception: 'Unauthorized Payment Attempt',
          metadata: {
            'community_id': _session.communityId,
            'user_id': signedInMember.user.id,
            'resident_id': residentId,
            'is_admin': isAdmin,
            'is_self': isSelf,
          },
        );

        throw Exception('No tienes permisos para registrar pagos de otros usuarios.');
      }

      await _source.registerPayment(
        communityId: _session.communityId,
        userId: residentId,
        amountInCents: amountInCents,
        date: date,
        reference: reference,
        note: note,
        receiptPath: receiptPath,
      );

      _logger.info(featureArea: 'SessionService',
        message: '[$featureArea] Payment successfully registered. Amount: $amountInCents cents');
    } catch (e, stackTrace) {
      await _logger.error(
        featureArea: featureArea,
        exception: e,
        stackTrace: stackTrace,
        metadata: {
          'community_id': _session.communityId,
          'target_user_id': residentId,
          'amount': amountInCents,
          'has_receipt': receiptPath.isNotEmpty,
        },
      );

      rethrow;
    }
  }
}
