import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText.four(title),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
