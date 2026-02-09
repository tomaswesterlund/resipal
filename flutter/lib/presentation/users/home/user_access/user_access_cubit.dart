import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_state.dart';
import 'package:rxdart/rxdart.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();
  final VisitorRepository _visitorRepository = GetIt.I<VisitorRepository>();
  StreamSubscription? _streamSubscription;

  UserAccessCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      await _streamSubscription?.cancel();

      _streamSubscription =
          CombineLatestStream.combine2(
            _invitationRepository.watchInvitationsByUserId(userId),
            _visitorRepository.watchVisitorsByUserId(userId),
            (invitations, visitors) {
              final activeInvitations = invitations.where((i) => i.isActive).toList();
              return LoadedState(activeInvitations, visitors);
            },
          ).listen(
            (state) => emit(state),
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserAccessCubit.initialize', stackTrace: s);
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
    _streamSubscription?.cancel();
    return super.close();
  }
}
