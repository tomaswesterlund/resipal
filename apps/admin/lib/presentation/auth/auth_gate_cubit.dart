import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gotrue/src/constants.dart';
import 'package:resipal_admin/presentation/auth/auth_gate_state.dart';
import 'package:core/lib.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();
  StreamSubscription? _authSubscription;

  AuthGateCubit() : super(InitialState());

  /// The entry point for the AuthGate
  void initialize() {
    // 1. Listen to real-time auth changes
    _authSubscription = _authService.onAuthStateChange.listen((authUser) async {
      switch (authUser.event) {
        case AuthChangeEvent.initialSession:
          if (authUser.session == null) {
            emit(UserNotSignedIn());
          } else {
            await _onUserSignedIn();
          }
        case AuthChangeEvent.passwordRecovery:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthChangeEvent.signedIn:
          await _onUserSignedIn();
        case AuthChangeEvent.signedOut:
          emit(UserNotSignedIn());
        case AuthChangeEvent.tokenRefreshed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthChangeEvent.userUpdated:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthChangeEvent.userDeleted:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthChangeEvent.mfaChallengeVerified:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }

  /// Private logic to check profile, community, and memberships
  Future<void> _onUserSignedIn() async {
    try {
      emit(LoadingState());
      final authUser = _authService.getSignedInUser();
      final userId = authUser.id;
      _sessionService.setUserId(userId);

      // Pre-fetch all necessary data
      await Future.wait([
        FetchUsers().call(),
        FetchCommunities().call(),
        FetchMembershipsByUserId().call(userId: userId),
      ]);

      // Check Profile
      final onboarded = await UserIsOnboarded().call(userId);
      if (!onboarded) return emit(UserNotOnboarded());

      // Check Membership
      final memberships = GetMembershipsByUserId().call(userId: userId);
      if (memberships.isEmpty) return emit(UserHasNoAdminMembership());

      // Success: Start real-time watchers for this specific community
      final community = GetCommunityById().call(memberships.first.community.id);

      await _sessionService.startCommunityWatchers(
        app: ResipalApplication.admin,
        userId: userId,
        communityId: community.id,
      );

      final admin = GetAdminMemberByCommunityIdAndUserId().call(communityId: community.id, userId: userId);

      emit(UserSignedIn(admin: admin, community: community));
    } catch (e) {
      _logger.error(featureArea: 'AuthGateCubit._onUserSignedIn', exception: e);
      emit(ErrorState());
    }
  }

  Future<void> _onUserSignedOut() async {
    await _sessionService.stopWatchers();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
