import 'package:flutter/material.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class UserAccessView extends StatelessWidget {
  const UserAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GreenBoxContainer(
          child: HeaderText.two('Accesos', color: Colors.white),
        ),
      ],
    );
  }
}
