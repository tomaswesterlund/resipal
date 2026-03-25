import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/visitors/watch_visitors_by_community_id_and_user_id.dart';

class VisitorsCubit extends Cubit<VisitorsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  final WatchVisitorsByCommunityIdAndUserId _watch = WatchVisitorsByCommunityIdAndUserId();
  StreamSubscription? _streamSubscription;

  VisitorsCubit() : super(VisitorsInitialState());

  Future initialize(List<VisitorEntity> visitors) async {
    try {
      emit(VisitorsLoadedState(visitors));

      _streamSubscription = _watch
          .call(communityId: _sessionService.communityId, userId: _sessionService.userId)
          .listen(
            (application) async {
              emit(VisitorsLoadedState(application));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'VisitorsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'visitors': visitors},
              );

              emit(VisitorsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'VisitorsCubit.initialize',
        stackTrace: s,
        metadata: {'visitors': visitors},
      );

      emit(VisitorsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
