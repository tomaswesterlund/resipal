import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:gotrue/src/constants.dart';
import 'package:resipal_security/presentation/auth/auth_gate_state.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();
  StreamSubscription? _authSubscription;

  AuthGateCubit() : super(AuthGateInitialState());

  void initialize() {
    try {
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
            await _sessionService.stopWatchers();
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
    } catch (e, s) {
      _logger.error(featureArea: 'AuthGateCubit', exception: e, stackTrace: s);
      emit(AuthGateErrorState());
    }
  }

  /// Private logic to check profile, community, and memberships
  Future<void> _onUserSignedIn(String userId) async {
    try {
      emit(AuthGateLoadingState());

      // Pre-fetch all necessary data
      await Future.wait([
        FetchUsers().call(),
        FetchCommunities().call(),
        FetchMembershipsByUserId().call(userId: userId),
      ]);

      // Check Profile
      final onboarded = await UserIsOnboarded().call(userId);
      if (!onboarded) return emit(AuthGateUserNotOnboarded());

      // Check Membership
      final memberships = GetMembershipsByUserId().call(userId: userId);
      if (memberships.isEmpty) return emit(AuthGateUserHasNoSecurityMembership());

      // TODO: Check if Security / Check if multiple memberships etc.
      final membership = memberships.first;

      if (membership.isSecurity == false) {
        emit(AuthGateUserHasNoSecurityMembership());
        return;
      }
      final community = membership.community;
      final resident = GetResidentByCommunityIdAndUserId().call(communityId: community.id, userId: userId);

      await _sessionService.startCommunityWatchers(
        app: ResipalApplication.security,
        userId: userId,
        communityId: community.id,
      );

      emit(UserSignedIn(resident));
    } catch (e, s) {
      _logger.error(featureArea: 'AuthGateCubit', exception: e, stackTrace: s);
      emit(AuthGateErrorState());
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
