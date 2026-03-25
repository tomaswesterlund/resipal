import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class ResidentOnboardingCubit extends Cubit<ResidentOnboardingState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();

  ResidentOnboardingCubit() : super(ResidentOnboardingInitialState());

  ResidentOnboardingFormState _formState = ResidentOnboardingFormState();

  void initialize(ApplicationEntity? application) {
    try {
      final user = _authService.getSignedInUser();
      _formState = _formState.copyWith(email: user.email);
      if (application != null) {
        _formState = _formState.copyWith(
          name: application.name,
          phoneNumber: application.phoneNumber,
          emergencyPhoneNumber: application.emergencyPhoneNumber,
        );
      }
      emit(ResidentOnboardingFormEditingState(_formState));
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'OnboardingRegistrationCubit.initialize',
        stackTrace: s,
        metadata: _formState.toMap(),
      );
      emit(ResidentOnboardingErrorState());
    }
  }

  void onNameChanged(String newName) {
    _formState = _formState.copyWith(name: newName);
    emit(ResidentOnboardingFormEditingState(_formState));
  }

  void onPhoneChanged(String newPhoneNumber) {
    _formState = _formState.copyWith(phoneNumber: newPhoneNumber);
    emit(ResidentOnboardingFormEditingState(_formState));
  }

  void onEmergencyPhoneChanged(String newEmergencyPhoneNumber) {
    _formState = _formState.copyWith(emergencyPhoneNumber: newEmergencyPhoneNumber);
    emit(ResidentOnboardingFormEditingState(_formState));
  }

  Future<void> submit() async {
    try {
      if (_formState.canSubmit == false) {
        return;
      }

      emit(ResidentOnboardingFormSubmittingState());
      final iii = _authService.getSignedInUserId();
      final userId = await CreateUser().call(
        userId: _authService.getSignedInUserId(),
        name: _formState.name,
        email: _formState.email,
        phoneNumber: _formState.phoneNumber,
        emergencyPhoneNumber: _formState.emergencyPhoneNumber,
      );

      await FetchUser().call(userId);
      await FetchApplications().call();
      final user = GetUserById().call(userId);

      emit(ResidentOnboardingFormSubmittedSuccessfully(user: user));
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'OnboardingRegistrationCubit.submit',
        stackTrace: s,
        metadata: _formState.toMap(),
      );
      emit(ResidentOnboardingErrorState());
    }
  }
}
