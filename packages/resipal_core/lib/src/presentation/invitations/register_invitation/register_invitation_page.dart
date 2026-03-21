import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
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
            if (state is RegisterInvitationNoPropertiesState) {
              return _NoProperties();
            }

            if (state is RegisterInvitationNoVisitorsState) {
              return _NoVisitors();
            }

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

            if (state is RegisterInvitationErrorState) {
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
            errorMessage: formState.property.errorMessage,
            onChanged: cubit.updateProperty,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          EntityDropdownField<VisitorEntity>(
            label: 'Visitante',
            items: formState.visitors,
            itemLabelBuilder: (v) => v.name,
            errorMessage: formState.visitor.errorMessage,
            onChanged: cubit.updateVisitor,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          DateRangePickerField(
            label: 'Vigencia de acceso',
            selectedRange: formState.dateRange.value,
            errorMessage: formState.dateRange.errorMessage,
            onRangeSelected: cubit.updateDateRange,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          TextInputField(
            label: 'Límite de entradas (Opcional)',
            hint: 'Ej: 5 (Dejar vacío para ilimitadas)',
            keyboardType: TextInputType.number,
            errorText: formState.maxEntries.errorMessage,
            onChanged: cubit.updateMaxEntries,
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'REGISTRAR INVITACIÓN', onPressed: cubit.submit),
          ),
        ],
      ),
    );
  }
}

class _NoProperties extends StatelessWidget {
  const _NoProperties();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_work_outlined, size: 64, color: colorScheme.outline),
            const SizedBox(height: 24),
            HeaderText.five('No hay propiedades registradas', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            BodyText.medium(
              'No puedes registrar una invitación si no existen propiedades en el sistema. '
              'Primero se deben dar de alta las unidades habitacionales; por favor, '
              'ponte en contacto con la administración para realizar este registro.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoVisitors extends StatelessWidget {
  const _NoVisitors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono con contenedor circular (Estilo Resipal/Wester)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.people_outline_rounded, size: 64, color: colorScheme.primary),
            ),
            const SizedBox(height: 32),

            // Título
            HeaderText.four('Sin visitantes', textAlign: TextAlign.center, color: colorScheme.primary),
            const SizedBox(height: 16),

            // Descripción
            Text(
              'No tienes visitantes registrados en tu agenda para crear esta invitación.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),

            // Instrucción adicional
            Text(
              'Primero debes dar de alta a la persona que deseas invitar.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
            ),
            const SizedBox(height: 32),

            // Link/Acción para crear visitante
            TextButton.icon(
              onPressed: () => Go.to(const RegisterVisitorPage()), // Ajustar a tu página real
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Registrar nuevo visitante'),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
