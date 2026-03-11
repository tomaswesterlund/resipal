import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/ui/my_app_bar.dart';

class ResidentHomePage extends StatelessWidget {
  final ResidentEntity resident;
  const ResidentHomePage({required this.resident, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(title: 'Residente'));
  }
}
