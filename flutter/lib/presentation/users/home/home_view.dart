import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: SafeArea(
      child: Column(children: [
        HeaderText.four('Accesos Rapidos'),
      ],),
    ),);
    
  }
}