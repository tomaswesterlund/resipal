import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class HomeOverviewCubit extends Cubit<AdminHomeOverviewState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  final WatchCommunityById _watchCommunityById = WatchCommunityById();
  StreamSubscription? _streamSubscription;

  HomeOverviewCubit() : super(AdminHomeOverviewInitialState());

  Future<void> initialize(CommunityEntity community, UserEntity user) async {
    try {
      emit(AdminHomeOverviewLoadedState(community: community, user: user));

      _streamSubscription = _watchCommunityById
          .call(communityId: community.id)
          .listen(
            (community) {
              emit(AdminHomeOverviewLoadedState(community: community, user: user));
            },
            onError: (e, s) {
              _logger.error(exception: e, stackTrace: s, featureArea: 'HomeOverviewCubit.initialize / listener');
              emit(AdminHomeOverviewErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'HomeOverviewCubit.initialize');
      emit(AdminHomeOverviewErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
