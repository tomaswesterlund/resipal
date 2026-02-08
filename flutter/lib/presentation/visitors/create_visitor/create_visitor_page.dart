import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/inputs/images/image_picker_buttons.dart';
import 'package:resipal/core/ui/inputs/images/image_preview.dart';
import 'package:resipal/core/ui/inputs/text_input_field.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/success_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_cubit.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_form_state.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_state.dart';

class CreateVisitorPage extends StatelessWidget {
  const CreateVisitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Crear visitante'),
      backgroundColor: AppColors.background,
      body: BlocProvider<CreateVisitorCubit>(
        create: (ctx) => CreateVisitorCubit()..initialize(),
        child: BlocConsumer<CreateVisitorCubit, CreateVisitorState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is InitialState || state is LoadingState) {
              return LoadingView();
            }

            if (state is NoPropertiesFoundState) {
              return Text('No se encontraron propiedades disponibles para asignar al visitante.');
              //return NoPropertiesFoundView();
            }

            if (state is FormSubmittingState) {
              return LoadingView(text: 'Procesando el nuevo visitante ...');
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
              return ErrorStateView();
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

    return Column(
      children: [
        TextInputField(label: 'Nombre', onChanged: cubit.updateName),
        const SizedBox(height: 12.0),
        if (formState.identificationImage != null)
          ImagePreview(imagePath: formState.identificationImage!.path, onDelete: () => cubit.removeImage())
        else
          ImagePickerButtons(
            onCamera: () => cubit.pickImage(ImageSource.camera),
            onGallery: () => cubit.pickImage(ImageSource.gallery),
          ),

          Spacer(),
          PrimaryCtaButton(label: 'Crear visitante', onPressed: () => cubit.submit())
      ],
    );
  }
}
