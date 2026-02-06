import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';
import 'package:resipal/presentation/properties/property_contract_view.dart';
import 'package:resipal/presentation/properties/property_general_information.dart';
import 'package:resipal/presentation/properties/property_maintenance_view.dart';

class PropertyDetailsPage extends StatefulWidget {
  final UserPropertyEntity property;
  const PropertyDetailsPage(this.property, {super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  int _currentIndex = 0;
  List<Widget> get _pages => [
    PropertyGeneralInformation(widget.property),
    PropertyMaintenanceView(widget.property),
    PropertyContractView(widget.property),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(title: 'Detalle de Propiedad'),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Información'),
          BottomNavigationBarItem(icon: Icon(Icons.house_outlined), label: 'Mantenimiento'),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined), label: 'Contrato'),
        ],
      ),
    );
  }
}
