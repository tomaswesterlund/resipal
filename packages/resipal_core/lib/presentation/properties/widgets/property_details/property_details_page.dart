import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/presentation/properties/widgets/property_details/property_contract_view.dart';
import 'package:resipal_core/presentation/properties/widgets/property_details/property_general_information.dart';
import 'package:resipal_core/presentation/properties/widgets/property_details/property_maintenance_view.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/floating_nav_bar.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';

class PropertyDetailsPage extends StatefulWidget {
  final PropertyEntity property;
  const PropertyDetailsPage(this.property, {super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  int _currentIndex = 0;
  List<Widget> get _pages => [PropertyGeneralInformation(widget.property), PropertyMaintenanceView(widget.property), PropertyContractView(widget.property)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: BaseAppColors.background,
      appBar: MyAppBar(title: 'Detalle de Propiedad'),
      body: _pages[_currentIndex],

      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentIndex,
        onChanged: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          FloatingNavBarItem(icon: Icons.info_outline, label: 'Información'),
          FloatingNavBarItem(icon: Icons.house_outlined, label: 'Mantenimiento', showDanger: widget.property.hasDebt),
          FloatingNavBarItem(icon: Icons.document_scanner_outlined, label: 'Contrato'),
        ],
      ),
    );
  }
}
