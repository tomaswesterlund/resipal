import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class SendInvitationWhatsappMessage {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final WhatsAppDataSource _source = GetIt.I<WhatsAppDataSource>();

  Future call({required String phoneNumber, required String personName, required String communityName}) async {
    // TODO: Add logging
    try {
      await _source.sendInvitationWhatsAppMessage(
        phoneNumber: phoneNumber,
        personName: personName,
        communityName: communityName,
      );
    } catch (e, s) {
      _logger.error(featureArea: 'SendInvitationWhatsappMessage', exception: e, stackTrace: s);
      rethrow;
    }
  }
}
