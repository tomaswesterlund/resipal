import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/session_service.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';

class CreateInvitationCubit extends Cubit<CreateInvitationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();
  final PropertyRepository _propertyRepository = GetIt.I<PropertyRepository>();
  final VisitorRepository _visitorRepository = GetIt.I<VisitorRepository>();

  late CreateInvitationFormState _formState;

  CreateInvitationCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());

      final userId = _sessionService.getSignedInUserId();
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
        userId: _sessionService.getSignedInUserId(),
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

class CreateInvitationState {}

class InitialState extends CreateInvitationState {}

class LoadingState extends CreateInvitationState {}

class FormEditingState extends CreateInvitationState {
  final CreateInvitationFormState formState;

  FormEditingState({required this.formState});
}

class NoPropertiesFoundState extends CreateInvitationState {}

class NoVisitorsFoundState extends CreateInvitationState {}

class FormSubmittingState extends CreateInvitationState {}

class FormSubmittedSuccessfullyState extends CreateInvitationState {}

class ErrorState extends CreateInvitationState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}

class CreateInvitationFormState {
  final List<PropertyEntity> properties;
  final List<VisitorEntity> visitors;

  final PropertyEntity? property;
  final VisitorEntity? visitor;
  final DateTimeRange? dateRange;

  bool get canSubmit {
    if (property == null) return false;
    if (visitor == null) return false;
    if (dateRange == null) return false;

    return true;
  }

  CreateInvitationFormState({required this.properties, required this.visitors, this.property, this.visitor, this.dateRange});

  CreateInvitationFormState copyWith({PropertyEntity? property, VisitorEntity? visitor, DateTimeRange? dateRange}) {
    return CreateInvitationFormState(
      properties: properties,
      visitors: visitors,
      property: property ?? this.property,
      visitor: visitor ?? this.visitor,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}
