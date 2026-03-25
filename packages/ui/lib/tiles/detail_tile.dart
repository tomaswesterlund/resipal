import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;
  final bool enableCopy;
  final VoidCallback? onPressed; // Added optional onPressed

  const DetailTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color,
    this.enableCopy = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color iconColor = color ?? colorScheme.primary;

    return ListTile(
      onTap: onPressed, // Becomes interactive if not null
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        label.toUpperCase(),
        style: TextStyle(fontSize: 10, color: theme.hintColor, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
      subtitle: Text(
        value,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface.withOpacity(0.87),
        ),
      ),
      trailing: _buildTrailing(colorScheme),
    );
  }

  Widget? _buildTrailing(ColorScheme colorScheme) {
    if (enableCopy) {
      return IconButton(
        icon: Icon(Icons.copy_rounded, size: 18, color: colorScheme.primary),
        onPressed: () => _copyToClipboard(null), // Context optional if using ScaffoldMessenger.maybeOf
        tooltip: 'Copiar',
      );
    }

    // Show chevron if tile is clickable but doesn't have a copy action
    if (onPressed != null) {
      return Icon(Icons.chevron_right_rounded, size: 20, color: colorScheme.outline);
    }

    return null;
  }

  void _copyToClipboard(BuildContext? context) {
    Clipboard.setData(ClipboardData(text: value));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copiado al portapapeles'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
