import 'package:core/lib.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  final LoggerService _logger = GetIt.instance<LoggerService>();

  String _formatPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[\s\+\-]'), '');
  }

  Future<void> sendMessage({required String phoneNumber, required String message}) async {
    final cleanPhone = _formatPhoneNumber(phoneNumber);
    final encodedMessage = Uri.encodeComponent(message);

    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone?text=$encodedMessage');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(
          whatsappUri,
          mode: LaunchMode.externalApplication, // Ensures it opens the actual app
        );
      } else {
        throw 'Could not launch WhatsApp for $cleanPhone';
      }
    } catch (e, s) {
      _logger.error(featureArea: 'WhatsAppService', exception: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> sendSupportMessage() async {
    await sendMessage(
      phoneNumber: Constants.supportPhoneNumber,
      message: 'Hola, necesito ayuda con el acceso a Resipal Admin.',
    );
  }
}
