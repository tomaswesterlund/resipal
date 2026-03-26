import 'package:core/lib.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  final LoggerService _logger = GetIt.instance<LoggerService>();

  /// Helper to encode query parameters according to RFC 3986
  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  Future<void> sendEmail({required String email, required String subject, String body = ''}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters({'subject': subject, 'body': body}),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Could not launch email client for $email';
      }
    } catch (e, s) {
      _logger.error(featureArea: 'EmailService', exception: e, stackTrace: s);
      rethrow;
    }
  }

  /// Convenience method for support-related emails
  Future<void> sendSupportEmail() async {
    await sendEmail(
      email: Constants.supportEmail,
      subject: 'Soporte Acceso - Resipal Admin',
      body: 'Hola, tengo problemas para acceder a mi cuenta. Mi usuario es: ',
    );
  }
}
