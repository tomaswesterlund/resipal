import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';
import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_cubit.dart';
import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_form_state.dart';
import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_state.dart';
import 'package:resipal_core/presentation/properties/views/no_properties_found_view.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/inputs/date_range_picker_field.dart';
import 'package:resipal_core/presentation/shared/inputs/entry_dropdown_field.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/success_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:resipal_core/presentation/visitors/views/no_visitors_found_view.dart';

class CreateInvitationPage extends StatelessWidget {
  const CreateInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Registrar invitación'),
      backgroundColor: BaseAppColors.background,
      body: BlocProvider<CreateInvitationCubit>(
        create: (ctx) => CreateInvitationCubit()..initialize(),
        child: BlocConsumer<CreateInvitationCubit, CreateInvitationState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is InitialState || state is LoadingState) {
              return LoadingView();
            }

            if (state is NoPropertiesFoundState) {
              return NoPropertiesFoundView();
            }

            if (state is NoVisitorsFoundState) {
              return NoVisitorsFoundView(onPressed: () {});
            }

            if (state is FormSubmittingState) {
              return LoadingView(title: 'Procesando la nueva invitación ...');
            }

            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: 'Invitación registrada!',
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
  final CreateInvitationFormState formState;

  const _Loaded({required this.formState, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateInvitationCubit>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          EntityDropdownField<PropertyEntity>(
            label: "Seleccionar propiedad",
            items: formState.properties,
            value: null,
            itemLabel: (property) => property.name,
            onChanged: (property) => cubit.onPropertySelected(property),
          ),
          SizedBox(height: 20.0),
          EntityDropdownField<VisitorEntity>(
            label: "Seleccionar visitante",
            items: formState.visitors,
            value: null,
            itemLabel: (visitor) => visitor.name,
            onChanged: (visitor) => cubit.onVisitorSelected(visitor),
          ),
          SizedBox(height: 20.0),
          DateRangePickerField(
            label: 'Rango de fechas',
            selectedRange: formState.dateRange,
            onRangeSelected: (dateRange) =>
                cubit.onDateRangeSelected(dateRange),
          ),
          SizedBox(height: 20.0),
          PrimaryCtaButton(
            label: 'Registrar invitación',
            canSubmit: formState.canSubmit,
            onPressed: () => cubit.submit(),
          ),
        ],
      ),
    );
  }
}
