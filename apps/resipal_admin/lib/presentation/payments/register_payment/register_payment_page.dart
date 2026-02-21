import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_admin/shared/buttons/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/inputs/text_input_field.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/success_view.dart';
import 'register_payment_cubit.dart';
import 'register_payment_state.dart';
import 'register_payment_form_state.dart';

class RegisterPaymentPage extends StatelessWidget {
  const RegisterPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Registrar Pago'),
      body: BlocProvider(
        create: (context) => RegisterPaymentCubit(),
        child: BlocConsumer<RegisterPaymentCubit, RegisterPaymentState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FormSubmittingState) return const LoadingView(title: 'Procesando pago...');
            if (state is ErrorState) return ErrorView();
            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Pago Registrado!',
                subtitle: 'El saldo del residente ha sido actualizado correctamente.',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }
            if (state is FormEditingState) return _PaymentForm(state.formState);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PaymentForm extends StatelessWidget {
  final RegisterPaymentFormState formState;
  const _PaymentForm(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPaymentCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Resident Dropdown Placeholder (Implement your actual searchable dropdown here)
          const TextInputField(
            label: 'Residente',
            hint: 'Selecciona un residente',
            isRequired: true,
            prefixIcon: Icon(Icons.person_search_rounded),
            readOnly: true, // Typically triggers a selection modal
          ),
          const SizedBox(height: 24),
          TextInputField(
            label: 'Monto del Pago',
            hint: '0.00',
            isRequired: true,
            prefixIcon: const Icon(Icons.attach_money),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: cubit.updateAmount,
          ),
          const SizedBox(height: 24),
          TextInputField(
            label: 'Referencia / No. de Operación',
            hint: 'Ej: TRANS-12345',
            isRequired: true,
            onChanged: cubit.updateReference,
          ),
          const SizedBox(height: 24),
          TextInputField(
            label: 'Nota Interna',
            hint: 'Ej: Pago adelantado de marzo',
            maxLines: 2,
            onChanged: cubit.updateNote,
          ),
          const SizedBox(height: 24),
          _ImagePickerSection(selectedImage: formState.receiptImage, onImageSelected: cubit.updateReceiptImage),
          const SizedBox(height: 48),
          PrimaryCtaButton(label: 'REGISTRAR PAGO', canSubmit: formState.canSubmit, onPressed: () => cubit.submit()),
        ],
      ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  final XFile? selectedImage;
  final Function(XFile?) onImageSelected;

  const _ImagePickerSection({this.selectedImage, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Comprobante (Imagen)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final image = await picker.pickImage(source: ImageSource.gallery);
            onImageSelected(image);
          },
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            ),
            child: selectedImage == null
                ? const Icon(Icons.add_a_photo_outlined, color: Colors.grey, size: 40)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(File(selectedImage!.path), fit: BoxFit.cover),
                  ),
          ),
        ),
      ],
    );
  }
}
