import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/home/resident/home_page/resident_home_page_state.dart';

class ResidentHomePageCubit extends Cubit<ResidentHomePageState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final GetCommunityById _getCommunityById = GetCommunityById();
  final WatchMemberByCommunityAndUserId _watchMemberByCommunityAndUserId = WatchMemberByCommunityAndUserId();
  StreamSubscription? _streamSubscription;

  ResidentHomePageCubit() : super(ResidentInitialState());

  Future<void> initialize(CommunityEntity community, MemberEntity member) async {
    try {
      emit(ResidentLoadedState(community, member));

      _streamSubscription = _watchMemberByCommunityAndUserId
          .call(communityId: member.community.id, userId: member.user.id)
          .listen(
            (member) {
              final community = _getCommunityById.call(member.community.id);
              emit(ResidentLoadedState(community, member));
            },
            onError: (e, s) {
              _logger.error(exception: e, stackTrace: s, featureArea: 'ResidentHomeCubit.initialize / listener');
              emit(ResidentErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'ResidentHomeCubit.initialize');
      emit(ResidentErrorState());
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
