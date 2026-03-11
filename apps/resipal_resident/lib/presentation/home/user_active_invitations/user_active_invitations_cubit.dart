import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/use_cases/get_active_user_invitations.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:resipal_user/presentation/home/user_active_invitations/user_active_invitations_state.dart';

class UserActiveInvitationsCubit extends Cubit<UserActiveInvitationsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  UserActiveInvitationsCubit() : super(InitialState());

  Future intialize(String userId) async {
    try {
      emit(LoadingState());
      final invitations = GetActiveUserInvitations().call(userId);
      emit(LoadedState(invitations));
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'UserActiveInvitationsCubit.intialize',
        stackTrace: s,
      );
      emit(ErrorState());
    }
  }
}
