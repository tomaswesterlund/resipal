import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class OnboardingUserRegistrationCubit extends Cubit<OnboardingUserRegistrationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();

  OnboardingUserRegistrationCubit() : super(OnboardingUserRegistrationInitialState());

  OnboardingUserRegistrationFormState _formState = OnboardingUserRegistrationFormState();

  void initialize() {
    try {
      final user = _authService.getSignedInUser();
      _formState = _formState.copyWith(email: user.email);
      emit(OnboardingUserRegistrationFormEditingState(_formState));
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'OnboardingRegistrationCubit.initialize',
        stackTrace: s,
        metadata: _formState.toMap(),
      );
      emit(OnboardingUserRegistrationErrorState());
    }
  }

  void onNameChanged(String newName) {
    _formState = _formState.copyWith(name: newName);
    emit(OnboardingUserRegistrationFormEditingState(_formState));
  }

  void onPhoneChanged(String newPhoneNumber) {
    _formState = _formState.copyWith(phoneNumber: newPhoneNumber);
    emit(OnboardingUserRegistrationFormEditingState(_formState));
  }

  void onEmergencyPhoneChanged(String newEmergencyPhoneNumber) {
    _formState = _formState.copyWith(emergencyPhoneNumber: newEmergencyPhoneNumber);
    emit(OnboardingUserRegistrationFormEditingState(_formState));
  }

  Future<void> submit() async {
    try {
      if (_formState.canSubmit == false) {
        return;
      }

      emit(OnboardingUserRegistrationFormSubmittingState());
      final userId = await CreateUser().call(
        name: _formState.name,
        email: _formState.email,
        phoneNumber: _formState.phoneNumber,
        emergencyPhoneNumber: _formState.emergencyPhoneNumber
      );

      await FetchUser().call(userId);

      emit(OnboardingUserRegistrationFormSubmittedSuccessfully());
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'OnboardingRegistrationCubit.submit',
        stackTrace: s,
        metadata: _formState.toMap(),
      );
      emit(OnboardingUserRegistrationErrorState());
    }
  }
}
