import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class RegisterApplicationCubit extends Cubit<RegisterApplicationState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  RegisterApplicationCubit() : super(RegisterApplicationInitialState());

  RegisterApplicationFormState _formState = RegisterApplicationFormState();

  FocusNode emailFocusNode = FocusNode();

  void initialize() {
    emit(RegisterApplicationFormEditingState(_formState));

    emailFocusNode.addListener(() => onEmailFocusChanged(emailFocusNode.hasFocus));
  }

  void updateName(String val) => _update(() => _formState.copyWith(name: val));

  void updateEmail(String newEmail) {
    // CHECK IF EMAIL IS VALID
    final emailIsValid = Validators.isValidEmail(_formState.email.value);
    if (!emailIsValid) {
      final email = _formState.email.copyWith(value: _formState.email.value, errorMessage: 'El email no es válido.');
      _formState = _formState.copyWith(email: email);
      emit(RegisterApplicationFormEditingState(_formState));
      return;
    }

    // CHECK IF USER EXISTS
    final membershipExists = MemberExistsByEmail().call(email: _formState.email.value);
    if (membershipExists) {
      final email = _formState.email.copyWith(
        value: _formState.email.value,
        errorMessage: 'El email está registrado a un miembro.',
      );
      _formState = _formState.copyWith(email: email);
      emit(RegisterApplicationFormEditingState(_formState));
      return;
    }

    final email = _formState.email.copyWith(value: newEmail, clearError: true);
    _formState = _formState.copyWith(email: email);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void onEmailFocusChanged(bool hasFocus) {
    if (hasFocus) return;

    // CHECK IF EMAIL ALREADY EXISTS IN APPLICATION!
    final applicationExists = ApplicationExistsByEmail().call(email: _formState.email.value);
    if (applicationExists) {
      final email = _formState.email.copyWith(
        value: _formState.email.value,
        errorMessage: 'El email ya está registrado a una solicitud.',
      );
      _formState = _formState.copyWith(email: email);
      emit(RegisterApplicationFormEditingState(_formState));
      return;
    }
  }

  void updatePhone(String val) => _update(() => _formState.copyWith(phoneNumber: val));
  void updateEmergencyPhone(String val) => _update(() => _formState.copyWith(emergencyPhoneNumber: val));
  void updateMessage(String val) => _update(() => _formState.copyWith(message: val));
  void toggleAdmin(bool? val) => _update(() => _formState.copyWith(isAdmin: val));
  void toggleResident(bool? val) => _update(() => _formState.copyWith(isResident: val));
  void toggleSecurity(bool? val) => _update(() => _formState.copyWith(isSecurity: val));

  void _update(RegisterApplicationFormState Function() next) {
    _formState = next();
    emit(RegisterApplicationFormEditingState(_formState));
  }

  bool get canSubmit {
    final state = _formState;
    if (state.name.isEmpty) return false;
    if (state.message.isEmpty) return false;
    if (state.email.value.trim().isEmpty || state.email.hasError) return false;
    //if (Validators.isValidPhone(phoneNumber) == false) return false;
    if (state.isAdmin == false && state.isResident == false && state.isSecurity == false) return false;

    return true;
  }

  Future<void> submit() async {
    if (state is! RegisterApplicationFormEditingState || canSubmit == false) return;

    emit(RegisterApplicationFormSubmittingState());

    try {
      await CreateApplicationAndSendInvitations().call(
        communityId: _sessionService.communityId,
        userId: null,
        name: _formState.name,
        email: _formState.email.value,
        phoneNumber: _formState.phoneNumber,
        emergencyPhoneNumber: _formState.emergencyPhoneNumber,
        status: ApplicationStatus.invited.toString(),
        message: _formState.message,
        isAdmin: _formState.isAdmin,
        isResident: _formState.isResident,
        isSecurity: _formState.isSecurity,
      );

      emit(RegisterApplicationFormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterApplicationCubit.submit');
      emit(RegisterApplicationErrorState());
    }
  }
}
