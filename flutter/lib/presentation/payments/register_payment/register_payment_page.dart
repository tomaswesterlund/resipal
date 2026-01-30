import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/inputs/amount_input_field.dart';
import 'package:resipal/core/ui/inputs/text_input_field.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/success_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_cubit.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_form_state.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_state.dart';

class RegisterPaymentPage extends StatelessWidget {
  const RegisterPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderText.two('Registrar un pago')),
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
              return LoadingView(text: 'Procesando el nuevo pago ...');
            }

            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Pago enviado!',
                subtitle:
                    'Tu comprobante está siendo revisado por administración.',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () {
                  Navigator.of(context).pop(); // Navigate back after success
                },
              );
            }

            if (state is ErrorState) {
              return ErrorStateView(
                errorMessage: state.errorMessage,
                exception: state.exception,
              );
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

    return SingleChildScrollView( // Added scroll for smaller screens
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountInputField(controller: cubit.amountController),
          const SizedBox(height: 12.0),
          TextInputField(label: 'Referencia', controller: cubit.referenceController),
          const SizedBox(height: 12.0),
          TextInputField(label: 'Nota', controller: cubit.noteController),
          const SizedBox(height: 24.0),
          HeaderText.four('Comprobante'),
          BodyText.small('Selecciona la opción para elegir una imagen.'),
          const SizedBox(height: 16.0),

          // --- Image Selection / Preview Area ---
          if (formState.receiptImage != null)
            _ImagePreview(
              imagePath: formState.receiptImage!.path,
              onDelete: () => cubit.removeImage(),
            )
          else
            _ImagePickerButtons(
              onCamera: () => cubit.pickImage(ImageSource.camera),
              onGallery: () => cubit.pickImage(ImageSource.gallery),
            ),

          const SizedBox(height: 8.0),
          const Center(
            child: BodyText.tiny('Solo se aceptan imágenes de la transferencia.'),
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

// Sub-widget for the Buttons
class _ImagePickerButtons extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  const _ImagePickerButtons({required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _PickerTile(icon: Icons.camera_alt_rounded, label: 'Cámara', onTap: onCamera)),
        const SizedBox(width: 16),
        Expanded(child: _PickerTile(icon: Icons.add_photo_alternate_outlined, label: 'Galería', onTap: onGallery)),
      ],
    );
  }
}

// Sub-widget for the Image Preview
class _ImagePreview extends StatelessWidget {
  final String imagePath;
  final VoidCallback onDelete;
  const _ImagePreview({required this.imagePath, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 8, right: 8,
          child: GestureDetector(
            onTap: onDelete,
            child: const CircleAvatar(backgroundColor: Colors.red, radius: 15, child: Icon(Icons.close, size: 18, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PickerTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue[800], size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}