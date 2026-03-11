import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CommunityDetailsCubit extends Cubit<CommunityDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  CommunityDetailsCubit() : super(CommunityDetailsInitialState());

  final WatchCommunityById _watchCommunityById = WatchCommunityById();
  StreamSubscription? _streamSubscription;

  void initialize(CommunityEntity community) {
    try {
      emit(CommunityDetailsLoadedState(community));

      _watchCommunityById
          .call(communityId: community.id)
          .listen(
            (community) => emit(CommunityDetailsLoadedState(community)),
            onError: (e, s) {
              _logger.error(featureArea: 'WatchCommunityById.onError', exception: e, stackTrace: s);
              emit(CommunityDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(featureArea: 'WatchCommunityById.initialize', exception: e, stackTrace: s);
      emit(CommunityDetailsErrorState());
    }
  }


@override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
  
}
