import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';
import 'package:resipal_core/domain/use_cases/create_invitation.dart';
import 'package:resipal_core/domain/use_cases/get_user_properties.dart';
import 'package:resipal_core/domain/use_cases/get_user_visitors.dart';
import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_form_state.dart';
import 'package:resipal_core/presentation/invitations/pages/create_invitation/create_invitation_state.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/logger_service.dart';

class CreateInvitationCubit extends Cubit<CreateInvitationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();

  late CreateInvitationFormState _formState;

  CreateInvitationCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());

      final userId = _authService.getSignedInUserId();
      final properties = GetUserProperties().call(userId);
      final visitors = GetUserVisitors().call(userId);

      if (properties.isEmpty) {
        emit(NoPropertiesFoundState());
        return;
      }

      if (visitors.isEmpty) {
        emit(NoVisitorsFoundState());
        return;
      }

      _formState = CreateInvitationFormState(
        properties: properties,
        visitors: visitors,
      );

      emit(FormEditingState(formState: _formState));
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'CreateInvitaitonCubit.initialize',
        stackTrace: stack,
      );
      emit(ErrorState());
    }
  }

  Future submit() async {
    try {
      emit(FormSubmittingState());

      await CreateInvitation().call(
        propertyId: _formState.property!.id,
        visitorId: _formState.visitor!.id,
        fromDate: _formState.dateRange!.start,
        toDate: _formState.dateRange!.end,
      );

      emit(FormSubmittedSuccessfullyState());
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'CreateInvitaitonCubit.submit',
        stackTrace: stack,
      );
      emit(ErrorState());
    }
  }

  void onPropertySelected(PropertyEntity? property) {
    _formState = _formState.copyWith(property: property);
    emit(FormEditingState(formState: _formState));
  }

  void onVisitorSelected(VisitorEntity? visitor) {
    _formState = _formState.copyWith(visitor: visitor);
    emit(FormEditingState(formState: _formState));
  }

  void onDateRangeSelected(DateTimeRange<DateTime>? dateRange) {
    _formState = _formState.copyWith(dateRange: dateRange);
    emit(FormEditingState(formState: _formState));
  }
}
