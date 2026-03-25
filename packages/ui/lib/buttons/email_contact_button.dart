import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ui/buttons/secondary_button.dart';

class EmailContactButton extends StatelessWidget {
  final String email;
  final String subject;
  final String body;
  final String? label;
  final IconData icon;

  const EmailContactButton({
    super.key,
    required this.email,
    this.subject = 'Soporte Resipal',
    this.body = '',
    this.label,
    this.icon = Icons.email_outlined,
  });

  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters({'subject': subject, 'body': body}),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'No se pudo abrir el cliente de correo';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(label: label ?? email, icon: icon, onPressed: () => _sendEmail(context));
  }
}
