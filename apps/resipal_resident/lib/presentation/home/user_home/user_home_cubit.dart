import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/use_cases/watch_user.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:resipal_user/presentation/home/user_home/user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  late final StreamSubscription? _streamSubscription;

  UserHomeCubit() : super(InitialState());

  void initialize(String userId) {
    try {
      emit(LoadingState());
      _streamSubscription = WatchUser()
          .call(userId)
          .listen(
            (user) => emit(LoadedState(user)),
            onError: (e, s) {
              _logger.logException(
                exception: e,
                featureArea: 'UserHomeCubit.initialize',
                stackTrace: s,
              );
              emit(ErrorState());
            },
          );
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'UserHomeCubit.initialize',
        stackTrace: s,
      );
      emit(ErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
