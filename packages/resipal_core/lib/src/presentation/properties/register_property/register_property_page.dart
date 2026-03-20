import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/contracts/no_active_contracts_found_view.dart';
import 'package:wester_kit/lib.dart';

class RegisterPropertyPage extends StatelessWidget {
  const RegisterPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Registrar una propiedad'),
      backgroundColor: colorScheme.background,
      body: BlocProvider<RegisterPropertyCubit>(
        create: (ctx) => RegisterPropertyCubit()..initialize(),
        child: BlocConsumer<RegisterPropertyCubit, RegisterPropertyState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is RegisterPropertyNoContractsFound) return const NoActiveContractsFoundView();
            if (state is RegisterPropertyFormEditingState) return _Form(state.formState);

            if (state is RegisterPropertyFormSubmittingState) {
              return const LoadingView(title: 'Registrando nueva propiedad ...');
            }

            if (state is RegisterPropertyFormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Propiedad registrada!',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }

            if (state is RegisterPropertyErrorState) return const ErrorView();
            return const UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterPropertyFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPropertyCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInputField(
            label: 'Nombre',
            hint: 'Ej: Lote o Casa 143',
            isRequired: true,
            helpText: 'El nombre oficial que aparecerá en los reportes y recibos.',
            onChanged: cubit.updateName,
          ),
          const SizedBox(height: 20.0),
          EntityDropdownField<ResidentMemberEntity>(
            label: "Seleccionar residente",
            isRequired: false,
            helpText: "Vincula un residente a esta propiedad.",
            items: formState.residents,
            value: null,
            itemLabelBuilder: (resident) => resident.user.name,
            onChanged: (resident) => cubit.onResidentSelected(resident),
          ),
          const SizedBox(height: 20.0),
          EntityDropdownField<ContractEntity>(
            label: "Seleccionar contrato",
            isRequired: true,
            readOnly: formState.resident == null ? true : false,
            helpText:
                "Vincula un contrato a esta propiedad. Solo obligatorio si la propiedad tiene un residente vinculado.",
            items: formState.contracts,
            value: null,
            itemLabelBuilder: (contract) => "${CurrencyFormatter.fromCents(contract.amountInCents)}: ${contract.name}",
            onChanged: (contract) => cubit.onContractSelected(contract),
          ),

          const SizedBox(height: 20.0),
          TextInputField(
            label: 'Descripción',
            hint: 'Breve descripción de la propiedad ...',
            isRequired: false,
            helpText: 'Detalles adicionales o notas internas para administración.',
            onChanged: cubit.updateDescription,
          ),
          const SizedBox(height: 32.0),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Registrar propiedad',
              canSubmit: formState.canSubmit,
              onPressed: () => cubit.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
