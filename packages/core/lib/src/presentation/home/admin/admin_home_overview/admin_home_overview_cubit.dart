import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/entities/members/admin_member_entity.dart';
import 'package:core/src/presentation/home/admin/admin_home_overview/admin_home_overview_state.dart';

class AdminHomeOverviewCubit extends Cubit<AdminHomeOverviewState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  final WatchCommunityById _watchCommunityById = WatchCommunityById();
  StreamSubscription? _streamSubscription;

  AdminHomeOverviewCubit() : super(AdminHomeOverviewInitialState());

  Future<void> initialize(CommunityEntity community, AdminMemberEntity admin) async {
    try {
      emit(AdminHomeOverviewLoadedState(community: community, admin: admin));

      _streamSubscription = _watchCommunityById
          .call(communityId: community.id)
          .listen(
            (community) {
              emit(AdminHomeOverviewLoadedState(community: community, admin: admin));
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
