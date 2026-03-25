import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/whatsapp_data_source.dart';
import 'package:core/src/domain/enums/whatsapp_recipient_type.dart';

class SendIndividualWhatsappMessage {
  final WhatsAppDataSource _source = GetIt.I<WhatsAppDataSource>();

  Future call({
    required String phoneNumber,
    required String message,
    WhatsappRecipientType recipentType = WhatsappRecipientType.individual,
  }) async {
    await _source.sendIndividualWhatsAppMessage(phoneNumber: phoneNumber, message: message);
  }
}
