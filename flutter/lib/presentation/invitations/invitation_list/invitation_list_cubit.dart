import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';

class InvitationListCubit extends Cubit<InvitationListState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final InvitationRepository _invitationRepository =
      GetIt.I<InvitationRepository>();

  InvitationListCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());

      _invitationRepository
          .watchInvitationsByUserId(userId)
          .listen(
            (invitations) => emit(LoadedState(invitations: invitations)),
            onError: (e) {
              emit(ErrorState(errorMessage: e.toString(), exception: e));
            },
          );
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'InvitationListCubit.initialize',
        stackTrace: stack,
        metadata: {'userId': userId},
      );
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }
}

class InvitationListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends InvitationListState {}

class LoadingState extends InvitationListState {}

class LoadedState extends InvitationListState {
  final List<InvitationEntity> invitations;

  LoadedState({required this.invitations});

  @override
  List<Object?> get props => [invitations];
}

class ErrorState extends InvitationListState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}
