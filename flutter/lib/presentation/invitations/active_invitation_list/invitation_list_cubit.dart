import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/use_cases/get_user_invitations.dart';

class ActiveInvitationListCubit extends Cubit<ActiveInvitationListState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  ActiveInvitationListCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      final invitations = GetUserInvitations().call(userId);
      emit(LoadedState(invitations: invitations));
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'InvitationListCubit.initialize',
        stackTrace: stack,
        metadata: {'userId': userId},
      );

      emit(ErrorState());
    }
  }
}

class ActiveInvitationListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ActiveInvitationListState {}

class LoadingState extends ActiveInvitationListState {}

class LoadedState extends ActiveInvitationListState {
  final List<InvitationEntity> invitations;

  LoadedState({required this.invitations});

  @override
  List<Object?> get props => [invitations];
}

class ErrorState extends ActiveInvitationListState {}
