import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/ui/my_app_bar.dart';

class ContractsPage extends StatelessWidget {
  final List<ContractEntity> contracts;
  const ContractsPage(this.contracts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Contratos'),
      body: ContractListView(contracts),
    );
  }
}
