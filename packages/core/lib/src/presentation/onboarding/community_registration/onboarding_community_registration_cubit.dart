import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/admin/get_admin_member_by_community_id_and_user_id.dart';

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
      await FetchUsers().call();
      await FetchMembershipsByUserId().call(userId: userId);

      final admin = GetAdminMemberByCommunityIdAndUserId().call(communityId: communityId, userId: userId);
      final community = GetCommunityById().call(communityId);

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
