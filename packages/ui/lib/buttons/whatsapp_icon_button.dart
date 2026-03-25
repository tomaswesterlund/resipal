import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsAppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const WhatsAppIconButton({super.key, required this.onPressed, this.size = 56.0});

  @override
  Widget build(BuildContext context) {
    const whatsappGreen = Color(0xFF25D366);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: whatsappGreen,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: whatsappGreen.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: const Center(child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 32)),
        ),
      ),
    );
  }
}
