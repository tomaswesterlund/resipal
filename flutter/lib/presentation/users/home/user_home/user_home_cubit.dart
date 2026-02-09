import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/presentation/users/home/user_home/user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();
  late final StreamSubscription? _streamSubscription;

  UserHomeCubit() : super(InitialState());

  void initialize(String userId) {
    try {
      emit(LoadingState());
      _streamSubscription = _userRepository
          .watchUserById(userId)
          .listen(
            (user) => emit(LoadedState(user)),
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserHomeCubit.initialize', stackTrace: s);
              emit(ErrorState());
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserHomeCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
