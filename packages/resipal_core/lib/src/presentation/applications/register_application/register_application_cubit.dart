import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class RegisterApplicationCubit extends Cubit<RegisterApplicationState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  RegisterApplicationCubit() : super(RegisterApplicationInitialState());

  late RegisterApplicationFormState _formState;

  void initialize() {
    _formState = const RegisterApplicationFormState();
    emit(RegisterApplicationFormEditingState(_formState));
  }

  void updateName(String val) => _update(() => _formState.copyWith(name: val));
  void updateEmail(String val) => _update(() => _formState.copyWith(email: val));
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

  Future<void> submit() async {
    if (state is! RegisterApplicationFormEditingState || !_formState.canSubmit) return;

    emit(RegisterApplicationFormSubmittingState());

    try {
      final dto = CreateApplicationDto(
        communityId: _sessionService.communityId,
        userId: null,
        name: _formState.name,
        email: _formState.email,
        phoneNumber: _formState.phoneNumber,
        emergencyPhoneNumber: _formState.emergencyPhoneNumber,
        status: ApplicationStatus.invited.toString(),
        message: _formState.message,
        isAdmin: _formState.isAdmin,
        isResident: _formState.isResident,
        isSecurity: _formState.isSecurity,
      );

      await CreateApplicationAndSendInvitations().call(dto);

      emit(RegisterApplicationFormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterApplicationCubit.submit');
      emit(RegisterApplicationErrorState());
    }
  }
}
