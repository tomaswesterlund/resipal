import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/members/get_signed_in_member.dart';

class ConfirmPaymentReceived {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _session = GetIt.I<SessionService>();
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future call({required String paymentId}) async {
    const String featureArea = 'ConfirmPaymentReceived';

    final member = GetSignedInMember().call();
    final payment = GetPaymentById().call(paymentId);

    final signedInMember = GetSignedInMember().call();

    final bool isSelf = signedInMember.user.id == payment.user.id;
    final bool isAdmin = signedInMember.isAdmin == true;

    if (!isSelf && !isAdmin) {
      await _logger.error(
        featureArea: featureArea,
        exception: 'Unauthorized Payment Attempt',
        metadata: {
          'community_id': _session.communityId,
          'user_id': signedInMember.user.id,
          'payment': payment.toMap(),
          'member': member.toMap(),
        },
      );

      throw Exception('No tienes permisos para registrar pagos de otros usuarios.');
    }

    if (payment.status != PaymentStatus.pendingReview) {
      final error = 'Action denied: Payment is not in Pending Review status (Current: ${payment.status.name}).';

      await _logger.error(
        featureArea: featureArea,
        exception: 'Unauthorized Payment Attempt',
        metadata: {
          'community_id': _session.communityId,
          'user_id': signedInMember.user.id,
          'payment': payment.toMap(),
          'member': member.toMap(),
        },
      );

      throw Exception(error);
    }

    await _source.updateStatus(id: paymentId, status: PaymentStatus.approved.toString());
  }
}
