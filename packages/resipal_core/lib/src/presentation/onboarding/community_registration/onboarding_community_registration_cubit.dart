import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class OnboardingCommunityRegistrationCubit extends Cubit<OnboardingCommunityRegistrationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  OnboardingCommunityRegistrationCubit() : super(OnboardingCommunityRegistrationInitialState());

  OnboardingCommunityRegistrationFormState _formState = OnboardingCommunityRegistrationFormState();

  void initialize() {
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  void onNameChanged(String value) {
    _formState = _formState.copyWith(name: value);
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  void onAddressChanged(String value) {
    _formState = _formState.copyWith(address: value);
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  void onDescriptionChanged(String value) {
    _formState = _formState.copyWith(location: value);
    emit(OnboardingCommunityRegistrationFormEditingState(_formState));
  }

  Future<void> submit() async {
    try {
      if (!_formState.canSubmit) return;

      emit(OnboardingCommunityRegistrationFormSubmittingState());

      final userId = _authService.getSignedInUserId();

      final communityId = await CreateCommunity().call(
        name: _formState.name,
        location: _formState.address,
        description: _formState.location,
      );

      final membershipId = CreateMembership().call(
        communityId: communityId,
        userId: userId,
        isAdmin: true,
        isResident: false,
        isSecurity: false,
      );

      await FetchCommunity().call(communityId);
      await FetchUsers().call(); // TODO Switch to listen by Community ID (we'll need Memberships)
      final community = GetCommunityById().call(communityId);
      final user = GetUserById().call(userId);

      await _sessionService.startWatchers(userId: userId, communityId: community.id);

      emit(OnboardingCommunityRegistrationFormSubmittedSuccessfully(community: community, user: user));
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
