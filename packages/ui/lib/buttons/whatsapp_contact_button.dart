import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppContactButton extends StatelessWidget {
  final String phoneNumber;
  final String message;
  final String? label;

  const WhatsAppContactButton({super.key, required this.phoneNumber, required this.message, this.label});

  Future<void> _launchWhatsApp(BuildContext context) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final encodedMessage = Uri.encodeComponent(message);

    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone?text=$encodedMessage');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir WhatsApp';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const whatsappGreen = Color(0xFF25D366);

    return ElevatedButton.icon(
      onPressed: () => _launchWhatsApp(context),
      icon: FaIcon(FontAwesomeIcons.whatsapp, size: 22, color: Colors.white),
      label: Text(label ?? phoneNumber, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

      style: ElevatedButton.styleFrom(
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
