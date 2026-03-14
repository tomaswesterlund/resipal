import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class RegisterInvitationPage extends StatelessWidget {
  

  const RegisterInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Registrar Invitación'),
      body: BlocProvider(
        create: (context) => RegisterInvitationCubit()..initialize(),
        child: BlocBuilder<RegisterInvitationCubit, RegisterInvitationState>(
          builder: (context, state) {
            if (state is RegisterInvitationSubmittingState) return const LoadingView();
            if (state is RegisterInvitationSuccessState) {
              return SuccessView(
                title: 'Invitación Creada!',
                actionButtonLabel: 'Volver',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );

            }
            if (state is RegisterInvitationFormEditingState) {
              return _Form(state.formState);
            }

            if(state is RegisterInvitationErrorState) {
              return ErrorView();
            }
            
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterInvitationFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterInvitationCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          EntityDropdownField<PropertyEntity>(
            label: 'Propiedad de destino',
            items: formState.properties,
            itemLabelBuilder: (p) => p.name,
            onChanged: cubit.updateProperty,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          EntityDropdownField<VisitorEntity>(
            label: 'Visitante',
            items: formState.visitors,
            itemLabelBuilder: (v) => v.name,
            onChanged: cubit.updateVisitor,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          DateRangePickerField(
            label: 'Vigencia de acceso',
            selectedRange: formState.dateRange,
            onRangeSelected: cubit.updateDateRange,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          TextInputField(
            label: 'Límite de entradas (Opcional)',
            hint: 'Ej: 5 (Dejar vacío para ilimitadas)',
            keyboardType: TextInputType.number,
            onChanged: cubit.updateMaxEntries,
          ),
          const SizedBox(height: 48),
          PrimaryButton(label: 'GENERAR INVITACIÓN', canSubmit: formState.canSubmit, onPressed: cubit.submit),
        ],
      ),
    );
  }
}
