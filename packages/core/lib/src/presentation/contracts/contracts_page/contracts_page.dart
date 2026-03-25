import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/lib.dart';

class ContractsPage extends StatelessWidget {
  final List<ContractEntity> initialContracts;

  const ContractsPage(this.initialContracts, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContractsCubit()..initialize(initialContracts),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Contratos',

          actions: [IconButton(icon: Icon(Icons.add), onPressed: () => Go.to(RegisterContractPage()))],
        ),
        body: BlocBuilder<ContractsCubit, ContractsState>(
          builder: (context, state) {
            if (state is ContractsLoadedState) {
              // Verificamos si la lista está vacía
              if (state.contracts.isEmpty) {
                return _NoContractsView();
              }
              return ContractListView(state.contracts);
            }

            if (state is ContractsErrorState) {
              return const Center(child: Text('Error al cargar contratos'));
            }

            return const Center(
              child: LoadingView(title: 'Cargando contratos', description: 'Sincronizando...'),
            );
          },
        ),
      ),
    );
  }
}

class _NoContractsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 80, color: colorScheme.primary.withOpacity(0.5)),
            const SizedBox(height: 24),
            HeaderText.three('Sin contratos activos', color: colorScheme.inverseSurface),
            const SizedBox(height: 12),
            Text(
              'No encontramos ningún contrato vinculado a esta comunidad.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            SecondaryButton(label: 'Registrar contrato', onPressed: () => Go.to(RegisterContractPage())),
            const SizedBox(height: 32),
            Divider(thickness: 1),
            const SizedBox(height: 32),
            BodyText.small('¿Algo no sale como esperabas?'),
            const SizedBox(height: 12),
            WhatsAppContactButton(
              phoneNumber: Constants.supportPhoneNumber,
              label: 'Solicitar ayuda',
              message: 'Hola, mi lista de contratos en Resipal aparece vacía y necesito ayuda.',
            ),
          ],
        ),
      ),
    );
  }
}
