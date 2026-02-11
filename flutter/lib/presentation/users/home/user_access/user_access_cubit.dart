import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/use_cases/get_active_user_invitations.dart';
import 'package:resipal/domain/use_cases/get_user_visitors.dart';
import 'package:resipal/domain/use_cases/watch_active_user_invitations.dart';
import 'package:resipal/domain/use_cases/watch_user_visitors.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_state.dart';
import 'package:rxdart/rxdart.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  StreamSubscription? _stream;

  UserAccessCubit() : super(InitialState());

  Future<void> initialize(String userId) async {
    try {
      emit(LoadingState());
      await _stream?.cancel();

      _stream =
          CombineLatestStream.combine2(WatchActiveInvitations().call(userId), WatchUserVisitors().call(userId), (
            invitations,
            visitors,
          ) {
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
