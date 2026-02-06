import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/presentation/users/home/user_active_invitations/user_active_invitations_state.dart';

class UserActiveInvitationsCubit extends Cubit<UserActiveInvitationsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();

  UserActiveInvitationsCubit() : super(InitialState());

  Future intialize(String userId) async {
    try {
      emit(LoadingState());
      final invitations = _invitationRepository.getActiveInvitationsByUserId(userId);
      emit(LoadedState(invitations));
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserActiveInvitationsCubit.intialize', stackTrace: s);
      emit(ErrorState());
    }
  }
}
