import 'package:flutter/material.dart';
import 'package:ui/extensions/nullable_string_extensions.dart';
import 'package:ui/texts/header_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;

  const MyAppBar({
    required this.title,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.backgroundColor, // Defaults to transparent if null
    this.foregroundColor,
    this.centerTitle = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolve Colors: priority to constructor, then theme defaults
    final bg = backgroundColor ?? Colors.transparent;
    final fg = foregroundColor ?? colorScheme.onSurface;

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title.isNotNullOrEmpty() ? HeaderText.four(title!, color: fg) : null,
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: bg,
      foregroundColor: fg,
      // Ensures back button and actions match the foreground color
      iconTheme: IconThemeData(color: fg),
      actions: actions,
      // Useful for managing status bar icon colors (dark vs light)
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
