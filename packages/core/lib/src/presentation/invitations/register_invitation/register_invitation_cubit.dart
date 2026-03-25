import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/invitations/register_invitation.dart';
import 'package:core/src/domain/use_cases/properties/get_properties_by_community_and_resident_id.dart';
import 'package:ui/lib.dart';

class RegisterInvitationCubit extends Cubit<RegisterInvitationState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  late RegisterInvitationFormState _formState;

  RegisterInvitationCubit() : super(RegisterInvitationInitialState());

  void initialize() {
    final properties = GetPropertiesByCommunityAndResidentId().call(
      communityId: _sessionService.communityId,
      residentId: _sessionService.userId,
    );
    final visitors = GetVisitorsByCommunityIdAndUserId().call(
      communityId: _sessionService.communityId,
      userId: _sessionService.userId,
    );

    if (properties.isEmpty) {
      emit(RegisterInvitationNoPropertiesState());
      return;
    }

    if (visitors.isEmpty) {
      emit(RegisterInvitationNoVisitorsState());
      return;
    }

    _formState = RegisterInvitationFormState(
      properties: properties,
      visitors: visitors,
      property: InputField<PropertyEntity?>(value: null, validators: [ValueNotNull()]),
      visitor: InputField<VisitorEntity?>(value: null, validators: [ValueNotNull()]),
      dateRange: InputField<DateTimeRange?>(value: null, validators: [ValueNotNull()]),
      maxEntries: InputField<int?>(value: null, validators: []),
    );
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateProperty(PropertyEntity? selectedProperty) {
    final property = _formState.property.copyWith(value: selectedProperty);
    _formState = _formState.copyWith(property: property);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateVisitor(VisitorEntity? selectedVisitor) {
    final visitor = _formState.visitor.copyWith(value: selectedVisitor);
    _formState = _formState.copyWith(visitor: visitor);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateDateRange(DateTimeRange? selectedDateRange) {
    final dateRange = _formState.dateRange.copyWith(value: selectedDateRange);
    _formState = _formState.copyWith(dateRange: dateRange);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateMaxEntries(String? value) {
    final entries = (value == null || value.isEmpty) ? null : int.tryParse(value);
    final maxEntries = _formState.maxEntries.copyWith(value: entries);
    _formState = _formState.copyWith(maxEntries: maxEntries);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  Future<void> submit() async {
    final state = _formState.validate();
    if (state.isValid == false) {
      emit(RegisterInvitationFormEditingState(state));
      return;
    }

    emit(RegisterInvitationSubmittingState());
    try {
      await RegisterInvitation().call(
        communityId: _sessionService.communityId,
        userId: _sessionService.userId,
        propertyId: state.property.value!.id,
        visitorId: state.visitor.value!.id,
        fromDate: state.dateRange.value!.start,
        toDate: state.dateRange.value!.end,
        maxEntries: state.maxEntries.value,
      );
      emit(RegisterInvitationSuccessState());
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterInvitation.submit');
      emit(RegisterInvitationErrorState());
    }
  }
}
