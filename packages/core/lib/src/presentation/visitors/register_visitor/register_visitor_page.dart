import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core/src/presentation/visitors/register_visitor/register_visitor_cubit.dart';
import 'package:ui/lib.dart';
import 'register_visitor_state.dart';
import 'register_visitor_form_state.dart';

class RegisterVisitorPage extends StatelessWidget {
  const RegisterVisitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Registrar Visitante'),
      backgroundColor: colorScheme.background,
      body: BlocProvider(
        create: (context) => RegisterVisitorCubit()..initialize(),
        child: BlocBuilder<RegisterVisitorCubit, RegisterVisitorState>(
          builder: (context, state) {
            if (state is RegisterVisitorSubmittingState) {
              return const LoadingView(title: 'Registrando visitante...');
            }

            if (state is RegisterVisitorErrorState) return const ErrorView();

            if (state is RegisterVisitorSuccessState) {
              return SuccessView(
                title: '¡Registro Exitoso!',
                subtitle: 'El visitante ha sido registrado en el sistema de seguridad.',
                actionButtonLabel: 'Volver',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }

            if (state is RegisterVisitorFormEditingState) {
              return _Form(state.formState);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterVisitorFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterVisitorCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText.five('Datos del Visitante'),
          const SizedBox(height: 8),
          BodyText.small('Ingresa la información oficial del visitante y captura su identificación.'),

          const SizedBox(height: 32),
          TextInputField(
            label: 'Nombre completo',
            hint: 'Ej: Juan Pérez',
            isRequired: true,
            errorText: formState.name.errorMessage,
            onChanged: cubit.updateName,
          ),

          const SizedBox(height: 32),
          const OverlineText('IDENTIFICACIÓN OFICIAL (INE / LICENCIA)'),
          const SizedBox(height: 12),

          if (formState.image.value != null)
            Stack(
              children: [
                XFileImagePreview(xFile: formState.image.value!),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: cubit.removeImage,
                    ),
                  ),
                ),
              ],
            )
          else
            ImagePickerButtons(
              onCamera: () => cubit.pickImage(ImageSource.camera),
              onGallery: () => cubit.pickImage(ImageSource.gallery),
              errorText: formState.image.errorMessage,
            ),

          const SizedBox(height: 48),

          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'REGISTRAR VISITANTE', onPressed: cubit.submit),
          ),
        ],
      ),
    );
  }
}
