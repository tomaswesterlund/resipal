import 'package:flutter/material.dart';
import 'package:resipal_core/helpers/nullable_string_extensions.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticallyImplyLeading;
  const MyAppBar({required this.title, this.automaticallyImplyLeading = true, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title.isNotNullOrEmpty() ? HeaderText.four(title!) : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
