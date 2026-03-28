import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/enums/resipal_application.dart';

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
        message:
            '[$featureArea] Starting payment registration for user: $residentId in community: $_session.communityId',
      );

      final signedInMember = GetSignedInMember().call();
      final community = GetCommunityById().call(_session.communityId);

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
            'community_id': community.id,
            'user_id': signedInMember.user.id,
            'resident_id': residentId,
            'is_admin': isAdmin,
            'is_self': isSelf,
          },
        );

        throw Exception('No tienes permisos para registrar pagos de otros usuarios.');
      }

      final model = UpsertPaymentModel(
        communityId: community.id,
        userId: residentId,
        amountInCents: amountInCents,
        status: isAdmin ? PaymentStatus.approved.toString() : PaymentStatus.pendingReview.toString(),
        date: date,
        receiptPath: receiptPath,
        reference: reference,
        note: note,
      );

      await _source.upsert(model);

      final String amountFormatted = (amountInCents / 100).toStringAsFixed(2);
      final String residentName = community.directory.members
          .firstWhere((m) => m.user.id == residentId, orElse: () => signedInMember)
          .user
          .name;

      // CREATE NOTIFICATIONS
      /// Inform all admins
      for (var admin in community.directory.admins) {
        // Don't notify the admin who just performed the action
        //if (admin.user.id == signedInMember.user.id) continue;

        await CreateNotification().call(
          communityId: community.id,
          userId: admin.user.id,
          app: ResipalApplication.admin,
          title: 'Nuevo Pago Registrado',
          message: isAdmin
              ? '${signedInMember.user.name} registró un pago de \$$amountFormatted para $residentName.'
              : '$residentName ha reportado un nuevo pago de \$$amountFormatted.',
        );
      }

      /// Inform resident
      await CreateNotification().call(
        communityId: community.id,
        userId: residentId,
        app: ResipalApplication.resident,
        title: isAdmin ? 'Pago Registrado por Admin' : 'Pago Recibido',
        message: isAdmin
            ? 'Un administrador ha registrado un pago de \$$amountFormatted en tu cuenta.'
            : 'Tu pago de \$$amountFormatted ha sido registrado y está en revisión.',
      );

      _logger.info(
        featureArea: 'RegisterPayment',
        message: '[$featureArea] Payment successfully registered. Amount: $amountInCents cents',
      );
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
