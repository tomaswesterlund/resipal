import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/use_cases/get_user_invitations.dart';
import 'package:resipal/domain/use_cases/get_user_visitors.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_state.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  StreamSubscription? _stream;

  UserAccessCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      await _stream?.cancel();
      final invitations = GetUserInvitations().call(userId);
      final visitors = GetUserVisitors().call(userId);

      emit(LoadedState(invitations, visitors));



      // _streamSubscription =
      //     CombineLatestStream.combine2(
      //       _invitationRepository.watchByUserId(userId),
      //       _visitorRepository.watchVisitorsByUserId(userId),
      //       (invitations, visitors) {
      //         final activeInvitations = invitations.where((i) => i.isActive).toList();
      //         return LoadedState(activeInvitations, visitors);
      //       },
      //     ).listen(
      //       (state) => emit(state),
      //       onError: (e, s) {
      //         _logger.logException(exception: e, featureArea: 'UserAccessCubit.initialize', stackTrace: s);
      //         emit(ErrorState());
      //       },
      //     );
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
