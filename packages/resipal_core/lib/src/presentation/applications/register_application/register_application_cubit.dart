import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class RegisterApplicationCubit extends Cubit<RegisterApplicationState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  RegisterApplicationCubit() : super(RegisterApplicationInitialState());

  RegisterApplicationFormState _formState = RegisterApplicationFormState(
    name: InputField(value: '', validators: [ValueNotEmpty()]),
    email: InputField(
      value: '',
      validators: [
        ValueNotEmpty(),
        EmailIsValid(),
        FunctionValidator<String>((value) {
          final exists = MemberExistsByEmail().call(email: value);
          return exists ? 'El email está registrado a un miembro.' : null;
        }),
        FunctionValidator<String>((value) {
          final exists = ApplicationExistsByEmail().call(email: value);
          return exists ? 'Ya existe una solicitud para este correo.' : null;
        }),
      ],
    ),
    phoneNumber: InputField(value: '', validators: [ValueNotEmpty(), PhoneNumberIsValid()]),
    emergencyPhoneNumber: InputField(value: '', validators: [PhoneNumberIsValid()]),
    message: InputField(value: '', validators: [ValueNotEmpty()]),
  );

  void initialize() {
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updateName(String newName) {
    final name = _formState.name.copyWith(value: newName, clearError: true);
    _formState = _formState.copyWith(name: name);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updateEmail(String newEmail) {
    final email = _formState.email.copyWith(value: newEmail, clearError: true);
    _formState = _formState.copyWith(email: email);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updatePhoneNumber(String newPhoneNumber) {
    final phoneNumber = _formState.phoneNumber.copyWith(value: newPhoneNumber, clearError: true);
    _formState = _formState.copyWith(phoneNumber: phoneNumber);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updateEmergencyPhoneNumber(String newEmergencyPhoneNumber) {
    final emergencyPhoneNumber = _formState.emergencyPhoneNumber.copyWith(
      value: newEmergencyPhoneNumber,
      clearError: true,
    );
    _formState = _formState.copyWith(emergencyPhoneNumber: emergencyPhoneNumber);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updateMessage(String newMessage) {
    final message = _formState.message.copyWith(value: newMessage, clearError: true);
    _formState = _formState.copyWith(message: message);
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void toggleAdmin(bool? val) => _update(() => _formState.copyWith(isAdmin: val));
  void toggleResident(bool? val) => _update(() => _formState.copyWith(isResident: val));
  void toggleSecurity(bool? val) => _update(() => _formState.copyWith(isSecurity: val));

  void _update(RegisterApplicationFormState Function() next) {
    _formState = next();
    emit(RegisterApplicationFormEditingState(_formState));
  }

  Future<void> submit() async {
    final state = _formState.validate();
    if (state.isValid == false) {
      emit(RegisterApplicationFormEditingState(state));
      return;
    }

    emit(RegisterApplicationFormSubmittingState());

    try {
      await CreateApplicationAndSendInvitations().call(
        communityId: _sessionService.communityId,
        userId: null,
        name: state.name.value,
        email: state.email.value,
        phoneNumber: state.phoneNumber.value,
        emergencyPhoneNumber: state.emergencyPhoneNumber.value,
        status: ApplicationStatus.invited.toString(),
        message: state.message.value,
        isAdmin: state.isAdmin,
        isResident: state.isResident,
        isSecurity: state.isSecurity,
      );

      emit(RegisterApplicationFormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterApplicationCubit.submit');
      emit(RegisterApplicationErrorState());
    }
  }
}
