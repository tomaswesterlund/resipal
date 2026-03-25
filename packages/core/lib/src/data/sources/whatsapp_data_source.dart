import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WhatsAppDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<void> sendIndividualWhatsAppMessage({required String phoneNumber, required String message}) async {
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    await _client.functions.invoke(
      'send_whatsapp_message',
      body: {
        'record': {'phone_number': cleanPhoneNumber, 'message': message, 'recipient_type': 'individual'},
      },
    );
  }

  Future sendInvitationWhatsAppMessage({
    required String phoneNumber,
    required String personName,
    required String communityName,
  }) async {
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    await _client.functions.invoke(
      'send_invitation_via_whatsapp',
      body: {
        'record': {
          'phone_number': cleanPhoneNumber,
          'person_name': personName,
          'community_name': communityName,
          'google_play_link': 'https://play.google.com/store/apps/details?id=app.resipal.resident',
        },
      },
    );
  }
}
