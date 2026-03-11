import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class SendInvitationEmail {
  final EmailInvitationDataSource _invitationDataSource = GetIt.I<EmailInvitationDataSource>();
  final EmailLogDataSource _logDataSource = GetIt.I<EmailLogDataSource>();

  Future<void> call({
    required String email,
    required String name,
    required String message,
    required String communityId,
  }) async {
    try {
      // TODO: Validation
      // Check if email already exists in memberships (already a member)
      // Check if email already exists in applications (already have an application)
      // Check if email already exists in email_invitations (should not be here if the first two are false)

      final model = EmailInvitationModel(
        id: '',
        communityId: communityId,
        createdAt: DateTime.now(),
        createdBy: '',
        email: email,
        name: name,
        message: message,
      );

      await _invitationDataSource.upsert(model.toUpsertMap());

      // 2. Trigger the Edge Function
      // Note: You might want your Edge Function to return the resend_id
      // so you can pass it to the logger.
      await _invitationDataSource.invokeSendInvitationEmail(email: email, name: name, message: message);

      // 3. Log the success (Optional: pass resend_id if returned by function)
      //await _logDataSource.logAttempt(invitationId: invitationId, resendId: 'pending_or_returned_id');
    } catch (e) {
      // Handle or rethrow errors
      rethrow;
    }
  }
}
