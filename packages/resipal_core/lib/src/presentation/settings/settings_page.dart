import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';
import 'package:wester_kit/ui/inputs/text_input_field.dart';
import 'package:wester_kit/ui/my_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Configuración'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeaderText(text: 'MANTENEMIENTO'),
              const SizedBox(height: 8.0),
              TextInputField(
                label: 'Periodo de Mantenemiento',
                initialValue: 'Mensual',
                hint: 'Mensual',
                readOnly: true,
                helpText: 'Frecuencia con la que se generan los cargos de mantenimiento para una propiedad.',
              ),
              const SizedBox(height: 20.0),
              TextInputField(
                label: 'Primer cobro para propiedades nuevas',
                initialValue: 'El día 1 del siguiente mes',
                hint: 'El día 1 del siguiente mes',
                readOnly: true,
                helpText: 'Define cuándo se emite la primera cuota de mantenemiento tras dar de alta una propiedad.',
              ),
              const SizedBox(height: 20.0),
              TextInputField(
                label: 'Días de Gracia',
                initialValue: '10',
                hint: 'Ej. 10',
                readOnly: true,
                helpText: 'Días adicionales después del día 1 para pagar sin generar recargos.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
