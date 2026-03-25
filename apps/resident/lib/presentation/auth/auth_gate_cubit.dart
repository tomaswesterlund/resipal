import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:resident/presentation/auth/auth_gate_state.dart';
import 'package:gotrue/src/constants.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final SessionService _session = GetIt.I<SessionService>();
  StreamSubscription? _authSubscription;

  AuthGateCubit() : super(AuthGateInitialState());

  /// The entry point for the AuthGate
  void initialize() {
    // 1. Listen to real-time auth changes
    _authSubscription = _authService.onAuthStateChange.listen((authUser) async {
      switch (authUser.event) {
        case AuthChangeEvent.initialSession:
          if (authUser.session == null) {
            emit(AuthGateUserNotSignedIn());
          } else {
            await _onUserSignedIn(_authService.getSignedInUserId());
          }
        case AuthChangeEvent.passwordRecovery:
          throw UnimplementedError();
        case AuthChangeEvent.signedIn:
          await _onUserSignedIn(_authService.getSignedInUserId());
        case AuthChangeEvent.signedOut:
          await _session.stopWatchers();
          emit(AuthGateUserNotSignedIn());
        case AuthChangeEvent.tokenRefreshed:
          throw UnimplementedError();
        case AuthChangeEvent.userUpdated:
          throw UnimplementedError();
        case AuthChangeEvent.userDeleted:
          throw UnimplementedError();
        case AuthChangeEvent.mfaChallengeVerified:
          throw UnimplementedError();
      }
    });
  }

  /// Private logic to check profile, community, and memberships
  Future<void> _onUserSignedIn(String userId) async {
    try {
      emit(AuthGateLoadingState());
      final email = _authService.getSignedInUser().email;
      if (email == null) {
        emit(AuthGateErrorState());
        return;
      }

      // Pre-fetch all necessary data
      await Future.wait([
        FetchUsers().call(),
        FetchCommunities().call(),
        FetchMembershipsByUserId().call(userId: userId),
        FetchApplications().call(),
      ]);

      final onboarded = await UserIsOnboarded().call(userId);
      final applications = GetApplicationsByEmail().call(email: email).where((x) => x.isResident == true);

      if (onboarded == false) {
        final ApplicationEntity? application = applications.isNotEmpty ? applications.first : null;
        return emit(AuthGateUserNotOnboarded(application: application));
      }

      // Check Membership
      final memberships = GetMembershipsByUserId().call(userId: userId);
      final user = GetUserById().call(userId);
      if (memberships.isEmpty) return emit(AuthGateUserHasNoResidentMembership(user: user));

      // TODO: Check if resident / Check if we have a pending application etc.

      // Success: Start real-time watchers for this specific community
      final community = memberships.first.community;

      await _session.startCommunityWatchers(
        app: ResipalApplication.resident,
        userId: userId,
        communityId: community.id,
      );

      final resident = GetResidentByCommunityIdAndUserId().call(communityId: community.id, userId: userId);

      emit(UserSignedIn(resident));
    } catch (e) {
      emit(AuthGateErrorState());
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
