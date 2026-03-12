import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/home/admin/admin_home_page/admin_home_page_state.dart';

class AdminHomePageCubit extends Cubit<AdminHomePageState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final WatchCommunityById _watchCommunityById = WatchCommunityById();
  StreamSubscription? _streamSubscription;

  AdminHomePageCubit() : super(AdminInitialState());

  Future<void> initialize(CommunityEntity community, UserEntity user) async {
    try {
      emit(AdminLoadedState(community, user));

      _streamSubscription = _watchCommunityById
          .call(communityId: community.id)
          .listen(
            (community) {
              emit(AdminLoadedState(community, user));
            },
            onError: (e, s) {
              _logger.error(exception: e, stackTrace: s, featureArea: 'AdminHomeCubit.initialize / listener');
              emit(AdminErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'AdminHomeCubit.initialize');
      emit(AdminErrorState());
    }
  }

  Future signout() async {
    await _authService.signout();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
