import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'register_payment_cubit.dart';
import 'register_payment_form_state.dart';
import 'register_payment_state.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/inputs/amount_input_field.dart';
import 'package:resipal_core/presentation/shared/inputs/images/image_picker_buttons.dart';
import 'package:resipal_core/presentation/shared/inputs/images/image_preview.dart';
import 'package:resipal_core/presentation/shared/inputs/text_input_field.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/success_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';

class RegisterPaymentPage extends StatelessWidget {
  const RegisterPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Registrar un pago'),
      body: BlocProvider<RegisterPaymentCubit>(
        create: (ctx) => RegisterPaymentCubit()..initialize(),
        child: BlocConsumer<RegisterPaymentCubit, RegisterPaymentState>(
          listener: (ctx, state) {
            //if (state is FormSubmittedSuccessfully) {}
          },
          builder: (ctx, state) {
            if (state is FormEditingState) {
              return _Form(state.formState);
            }

            if (state is FormSubmittingState) {
              return LoadingView(title: 'Procesando el nuevo pago ...');
            }

            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Pago enviado!',
                subtitle:
                    'Tu comprobante está siendo revisado por administración.',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () {
                  Navigator.of(context).pop();
                },
              );
            }

            if (state is ErrorState) {
              return ErrorView();
            }

            return UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterPaymentFormState formState;
  const _Form(this.formState, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPaymentCubit>();

    return SingleChildScrollView(
      // Added scroll for smaller screens
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountInputField(onChanged: cubit.updateAmount),
          const SizedBox(height: 12.0),
          TextInputField(
            label: 'Referencia',
            hint: 'Referencia',
            onChanged: cubit.updateReference,
          ),
          const SizedBox(height: 12.0),
          TextInputField(
            label: 'Nota',
            hint: 'Nota',
            onChanged: cubit.updateNote,
          ),
          const SizedBox(height: 24.0),
          HeaderText.four('Comprobante'),
          BodyText.small('Selecciona la opción para elegir una imagen.'),
          const SizedBox(height: 16.0),

          // --- Image Selection / Preview Area ---
          if (formState.receiptImage != null)
            ImagePreview(
              imagePath: formState.receiptImage!.path,
              onDelete: () => cubit.removeImage(),
            )
          else
            ImagePickerButtons(
              onCamera: () => cubit.pickImage(ImageSource.camera),
              onGallery: () => cubit.pickImage(ImageSource.gallery),
            ),

          const SizedBox(height: 8.0),
          const Center(
            child: BodyText.tiny(
              'Solo se aceptan imágenes de la transferencia.',
            ),
          ),
          const SizedBox(height: 32.0),
          Center(
            child: PrimaryCtaButton(
              label: 'ENVIAR PAGO',
              canSubmit: formState.canSubmit,
              onPressed: () => cubit.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
