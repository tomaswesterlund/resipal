import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';
import 'package:resipal/presentation/invitations/create_invitation/create_invitation_form_state.dart';
import 'package:resipal/presentation/invitations/create_invitation/create_invitation_state.dart';

class CreateInvitationCubit extends Cubit<CreateInvitationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();
  final PropertyRepository _propertyRepository = GetIt.I<PropertyRepository>();
  final VisitorRepository _visitorRepository = GetIt.I<VisitorRepository>();

  late CreateInvitationFormState _formState;

  CreateInvitationCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());

      final userId = _authService.getSignedInUserId();
      final properties = await _propertyRepository.getPropertiesByUserId(userId);
      final visitors = await _visitorRepository.getVisitorsByUserId(userId);

      if (properties.isEmpty) {
        emit(NoPropertiesFoundState());
        return;
      }

      if (visitors.isEmpty) {
        emit(NoVisitorsFoundState());
        return;
      }

      _formState = CreateInvitationFormState(properties: properties, visitors: visitors);

      emit(FormEditingState(formState: _formState));
    } catch (e, stack) {
      _logger.logException(exception: e, featureArea: 'CreateInvitaitonCubit.initialize', stackTrace: stack);
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  Future submit() async {
    try {
      emit(FormSubmittingState());

      await _invitationRepository.createInvitation(
        userId: _authService.getSignedInUserId(),
        propertyId: _formState.property!.id,
        visitorId: _formState.visitor!.id,
        fromDate: _formState.dateRange!.start,
        toDate: _formState.dateRange!.end,
      );
      
      emit(FormSubmittedSuccessfullyState());
    } catch (e, stack) {
      _logger.logException(exception: e, featureArea: 'CreateInvitaitonCubit.submit', stackTrace: stack);
      emit(ErrorState(errorMessage: e.toString(), exception: e));
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


