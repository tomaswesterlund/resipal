import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/service_locator.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/use_cases/create_user.dart';
import 'package:resipal/domain/use_cases/fetch_user.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_form_state.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_state.dart';

class UserOnboardingUserDataCubit extends Cubit<UserOnboardingUserDataState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _loggerService = GetIt.I<LoggerService>();

  UserOnboardingUserDataCubit() : super(InitialState());

  late UserOnboardingUserDataFormState _formState;

  Future initialize() async {
    final authUser = _authService.getSignedInUser();
    _formState = UserOnboardingUserDataFormState(email: authUser.email);
    emit(FormEditingState(_formState));
  }

  Future submit() async {
    try {
      emit(FormSubmittingState());
      final authUser = _authService.getSignedInUser();
      await CreateUser().call(
        CreateUserCommand(
          userId: authUser.id,
          name: _formState.name!,
          phoneNumber: _formState.phoneNumber!,
          emergencyPhoneNumber: _formState.emergencyPhoneNumber!,
          email: _formState.email!,
        ),
      );

      await FetchUser().call(authUser.id);
      final user = GetUser().call(authUser.id);
      await ServiceLocator.initializeUserScope(user.id);

      emit(FormSubmittedSuccessfullyState(user));
    } catch (e, s) {
      _loggerService.logException(exception: e, featureArea: 'UserOnboardingCubit.submit', stackTrace: s);
      emit(ErrorState());
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
