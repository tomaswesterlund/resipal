import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
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
import 'package:resipal_core/presentation/visitors/pages/create_visitor/create_visitor_cubit.dart';
import 'package:resipal_core/presentation/visitors/pages/create_visitor/create_visitor_form_state.dart';
import 'package:resipal_core/presentation/visitors/pages/create_visitor/create_visitor_state.dart';

class CreateVisitorPage extends StatelessWidget {
  const CreateVisitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Registrar visitante'),
      backgroundColor: BaseAppColors.background,
      body: BlocProvider<CreateVisitorCubit>(
        create: (ctx) => CreateVisitorCubit()..initialize(),
        child: BlocConsumer<CreateVisitorCubit, CreateVisitorState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is InitialState || state is LoadingState) {
              return LoadingView();
            }

            if (state is NoPropertiesFoundState) {
              return Text(
                'No se encontraron propiedades disponibles para asignar al visitante.',
              );
              //return NoPropertiesFoundView();
            }

            if (state is FormSubmittingState) {
              return LoadingView(title: 'Registrando el visitante ...');
            }

            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: 'Visitante creado!',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () {
                  Navigator.of(context).pop();
                },
              );
            }

            if (state is FormEditingState) {
              return _Loaded(formState: state.formState);
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

class _Loaded extends StatelessWidget {
  final CreateVisitorFormState formState;

  const _Loaded({required this.formState});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateVisitorCubit>();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextInputField(
            label: 'Nombre',
            hint: 'Nombre',
            onChanged: cubit.updateName,
          ),
          const SizedBox(height: 24.0),
          HeaderText.four('Identificación'),
          BodyText.small('Selecciona la opción para elegir una imagen.'),
          const SizedBox(height: 16.0),

          // --- Image Selection / Preview Area ---
          if (formState.identificationImage != null)
            ImagePreview(
              imagePath: formState.identificationImage!.path,
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
              'Se requiere una identificación oficial vigente para autorizar el acceso.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32.0),
          Center(
            child: PrimaryCtaButton(
              icon: Icons.person,
              label: 'REGISTRAR VISITANTE',
              canSubmit: formState.isValid(),
              onPressed: () => cubit.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
