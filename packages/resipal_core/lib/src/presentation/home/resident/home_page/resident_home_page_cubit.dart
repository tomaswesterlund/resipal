import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/residents/watch_resident_by_community_id_and_user_id.dart';

class ResidentHomePageCubit extends Cubit<ResidentHomePageState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final NotificationService _notificationService = GetIt.I<NotificationService>();
  final GetCommunityById _getCommunityById = GetCommunityById();
  StreamSubscription? _streamSubscription;

  ResidentHomePageCubit() : super(ResidentInitialState());

  Future<void> initialize(CommunityEntity community, ResidentMemberEntity resident) async {
    try {
      emit(ResidentLoadedState(community, resident));
      await _notificationService.initialize(userId: resident.user.id);

      _streamSubscription = WatchResidentByCommunityIdAndUserId()
          .call(communityId: resident.community.id, userId: resident.user.id)
          .listen(
            (resident) {
              final community = _getCommunityById.call(resident.community.id);
              emit(ResidentLoadedState(community, resident));
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
