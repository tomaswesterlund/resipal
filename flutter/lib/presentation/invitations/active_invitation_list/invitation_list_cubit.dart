import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';

class ActiveInvitationListCubit extends Cubit<ActiveInvitationListState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationRepository _invitationRepository = GetIt.I<InvitationRepository>();

  ActiveInvitationListCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      final invitations = _invitationRepository.getActiveInvitationsByUserId(userId);
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
