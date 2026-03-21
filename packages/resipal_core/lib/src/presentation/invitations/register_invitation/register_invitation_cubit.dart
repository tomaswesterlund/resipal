import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/invitations/register_invitation.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_properties_by_community_and_resident_id.dart';

class RegisterInvitationCubit extends Cubit<RegisterInvitationState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  late RegisterInvitationFormState _formState;

  RegisterInvitationCubit() : super(RegisterInvitationInitialState());

  void initialize() {
    final properties = GetPropertiesByCommunityAndResidentId().call(communityId: _sessionService.communityId, residentId: _sessionService.userId);
    final visitors = GetVisitorsByCommunityIdAndUserId().call(
      communityId: _sessionService.communityId,
      userId: _sessionService.userId,
    );

    if(properties.isEmpty) {
      emit(RegisterInvitationNoPropertiesState());
      return;
    }

    if(visitors.isEmpty) {
      emit(RegisterInvitationNoVisitorsState());
      return;
    }

    _formState = RegisterInvitationFormState(properties: properties, visitors: visitors);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateProperty(PropertyEntity? property) {
    _formState = _formState.copyWith(property: property);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateVisitor(VisitorEntity? visitor) {
    _formState = _formState.copyWith(visitor: visitor);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateDateRange(DateTimeRange? range) {
    _formState = _formState.copyWith(dateRange: range);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  void updateMaxEntries(String? value) {
    final entries = (value == null || value.isEmpty) ? null : int.tryParse(value);
    _formState = _formState.copyWith(maxEntries: entries);
    emit(RegisterInvitationFormEditingState(_formState));
  }

  Future<void> submit() async {
    if (!_formState.canSubmit) return;

    emit(RegisterInvitationSubmittingState());
    try {
      await RegisterInvitation().call(
        communityId: _sessionService.communityId,
        userId: _sessionService.userId,
        propertyId: _formState.property!.id,
        visitorId: _formState.visitor!.id,
        fromDate: _formState.dateRange!.start,
        toDate: _formState.dateRange!.end,
        maxEntries: _formState.maxEntries,
        
      );
      emit(RegisterInvitationSuccessState());
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterInvitation.submit');
      emit(RegisterInvitationErrorState());
    }
  }
}
