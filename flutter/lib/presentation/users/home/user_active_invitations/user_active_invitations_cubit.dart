import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/presentation/users/home/user_active_invitations/user_active_invitations_state.dart';

class UserActiveInvitationsCubit extends Cubit<UserActiveInvitationsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();
  StreamSubscription<List<InvitationEntity>>? _streamSubscription;

  UserActiveInvitationsCubit() : super(UserActiveInvitationsState());

  Future intialize(String userId) async {
    try {
      await _streamSubscription?.cancel();
      emit(state.copyWith(isFetching: true));

      _streamSubscription = _invitationRepository
          .watchActiveInvitationsByUserId(userId)
          .listen(
            (invitations) {
              emit(UserActiveInvitationsState(isFetching: false, invitations: invitations));
            },
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserActiveInvitationsCubit.intialize', stackTrace: s);
              emit(UserActiveInvitationsState(errorMessage: e.toString(), exception: e));
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserActiveInvitationsCubit.intialize', stackTrace: s);
      emit(UserActiveInvitationsState(errorMessage: e.toString(), exception: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
