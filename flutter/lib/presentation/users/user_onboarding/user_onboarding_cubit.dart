import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/presentation/users/user_onboarding/user_onboarding_form_state.dart';
import 'package:resipal/presentation/users/user_onboarding/user_onboarding_state.dart';

class UserOnboardingCubit extends Cubit<UserOnboardingState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _loggerService = GetIt.I<LoggerService>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();

  UserOnboardingCubit() : super(InitialState());

  late UserOnboardingFormState _formState;

  Future initialize() async {
    final authUser = _authService.getSignedInUser();
    _formState = UserOnboardingFormState(email: authUser.email);
    emit(FormEditingState(_formState));
  }

  Future submit() async {
    try {
      emit(FormSubmittingState());
      final authUser = _authService.getSignedInUser();
      await _userRepository.createUser(
        id: authUser.id,
        name: _formState.name!,
        phoneNumber: _formState.phoneNumber!,
        emergencyPhoneNumber: _formState.emergencyPhoneNumber!,
        email: _formState.email!,
      );

      await _userRepository.fetchUser(authUser.id);
      final user = _userRepository.getUserById(authUser.id);

      emit(FormSubmittedSuccessfullyState(user));
    } catch (e, s) {
      _loggerService.logException(
        exception: e,
        featureArea: 'UserOnboardingCubit.submit',
        stackTrace: s,
      );
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  void updateName(String newValue) {
    _formState = _formState.copyWith(name: newValue);
    emit(FormEditingState(_formState));
  }

  void updatePhoneNumber(String newValue) {
    _formState = _formState.copyWith(phoneNumber: newValue);
    emit(FormEditingState(_formState));
  }

  void updateEmergencyPhoneNumber(String newValue) {
    _formState = _formState.copyWith(emergencyPhoneNumber: newValue);
    emit(FormEditingState(_formState));
  }
}
