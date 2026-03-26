import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

class OnboardingCommunityRegistrationCubit extends Cubit<OnboardingCommunityRegistrationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  OnboardingCommunityRegistrationCubit() : super(OnboardingCommunityRegistrationInitialState());

  OnboardingCommunityRegistrationFormState _formState = OnboardingCommunityRegistrationFormState(
    name: InputField(value: '', validators: [ValueNotEmpty()]),
    address: InputField(value: '', validators: [ValueNotEmpty()]),
    location: InputField(value: '', validators: []),
  );

  void initialize() {
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  void onNameChanged(String value) {
    final name = _formState.name.copyWith(value: value, clearError: true);
    _update(() => _formState.copyWith(name: name));
  }

  void onAddressChanged(String value) {
    final address = _formState.address.copyWith(value: value, clearError: true);
    _update(() => _formState.copyWith(address: address));
  }

  void onDescriptionChanged(String value) {
    final location = _formState.location.copyWith(value: value, clearError: true);
    _update(() => _formState.copyWith(location: location));
  }

  void toggleResident(bool? val) => _update(() => _formState.copyWith(isResident: val, clearRolesError: true));
  void toggleSecurity(bool? val) => _update(() => _formState.copyWith(isSecurity: val, clearRolesError: true));

  void _update(OnboardingCommunityRegistrationFormState Function() next) {
    _formState = next();
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  // --- Submission Logic ---

  Future<void> submit() async {
    final validatedState = _formState.validate();

    if (!validatedState.isValid) {
      _formState = validatedState;
      emit(OnboardingCommunityRegistrationFormEditingState(_formState));
      return;
    }

    try {
      emit(OnboardingCommunityRegistrationFormSubmittingState());

      final userId = _authService.getSignedInUserId();

      // 1. Create the Community
      final communityId = await CreateCommunity().call(
        name: _formState.name.value,
        location: _formState.address.value,
        description: _formState.location.value,
      );

      // 2. Create the Membership with selected roles
      await CreateMembership().call(
        communityId: communityId,
        userId: userId,
        isAdmin: true,
        isResident: _formState.isResident,
        isSecurity: _formState.isSecurity,
      );

      // 3. Refresh Data
      await Future.wait([
        FetchCommunity().call(communityId),
        FetchUsers().call(),
        FetchMembershipsByUserId().call(userId: userId),
      ]);

      final admin = GetAdminMemberByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

      final community = GetCommunityById().call(communityId);

      // 4. Initialize Session Watchers
      await _sessionService.startCommunityWatchers(
        app: ResipalApplication.admin,
        userId: userId,
        communityId: community.id,
      );

      emit(OnboardingCommunityRegistrationFormSubmittedSuccessfully(admin: admin, community: community));
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'OnboardingCommunityRegistrationCubit.submit',
        stackTrace: s,
        metadata: _formState.toMap(),
      );
      emit(OnboardingCommunityRegistrationErrorState());
    }
  }
}
