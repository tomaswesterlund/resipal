import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/use_cases/watch_active_user_invitations.dart';
import 'package:resipal_core/domain/use_cases/watch_user_visitors.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:resipal_user/presentation/home/user_access/user_access_state.dart';
import 'package:rxdart/streams.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  StreamSubscription? _stream;

  UserAccessCubit() : super(InitialState());

  Future<void> initialize(String userId) async {
    try {
      emit(LoadingState());
      await _stream?.cancel();
      _stream =
          CombineLatestStream.combine2(WatchActiveInvitations().call(userId), WatchUserVisitors().call(userId), (invitations, visitors) {
            return (invitations, visitors);
          }).listen(
            (data) {
              emit(LoadedState(data.$1, data.$2));
            },
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserAccessCubit.stream', stackTrace: s);
              emit(ErrorState());
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserAccessCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }
}
